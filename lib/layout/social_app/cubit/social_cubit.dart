import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/models/social_model/message_user_model.dart';
import 'package:new_flutter2/models/social_model/post_model.dart';
import 'package:new_flutter2/models/social_model/social_user_model.dart';
import 'package:new_flutter2/modules/social_app/chats/chats_screen.dart';
import 'package:new_flutter2/modules/social_app/feeds/feeds_screen.dart';
import 'package:new_flutter2/modules/social_app/newPost/new_post.dart';
import 'package:new_flutter2/modules/social_app/settings/settings_screen.dart';
import 'package:new_flutter2/modules/social_app/users/users_screen.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List titles = const [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  List screens = const [
    FeedsScreen(),
    ChatsScreen(),
    NewPost(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Paper_Upload),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Location),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Setting),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      printFullText(value.data().toString());
      model = SocialUserModel.fromJson(value.data()!);

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  /* void updateUserImages({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateProfileLoadingState());
    if (profileImageCoverUrl != null) {
      uploadProfileImageCover();
    } else if (profileImageUrl != null) {
      uploadProfileImage();
    } else if (profileImageUrl != null && profileImageCoverUrl != null) {
    } else {
      updateUser(
        name: name,
        bio: bio,
        phone: phone,
      );
    }
  }*/

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    SocialUserModel modelUser = SocialUserModel(
      uID: model!.uID,
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      email: model!.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(modelUser.uID)
        .update(modelUser.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialUpdateProfileErrorState());
    });
  }

  File? imageProfile;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      imageProfile = File(imagePicked.path);
      printFullText(imageProfile!.path.toString());
      emit(SocialProfileImagePickerSuccessState());
    } else {
      printFullText('no enter image');
      emit(SocialProfileImagePickerErrorState());
    }
  }

  File? imageCover;

  Future<void> getCover() async {
    final coverP = await picker.pickImage(source: ImageSource.gallery);
    if (coverP != null) {
      imageCover = File(coverP.path);
      emit(SocialProfileCoverSuccessState());
    } else {
      printFullText('no enter cover');
      emit(SocialProfileCoverErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        printFullText(value.toString());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
        //emit(SocialUploadProfileImagePickerSuccessState());
      }).catchError((error) {
        printFullText(error.toString());
        emit(SocialUploadProfileImagePickerErrorState());
      });
      printFullText(p0.toString());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialUploadProfileImagePickerErrorState());
    });
  }

  void uploadProfileImageCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCover!.path).pathSegments.last}')
        .putFile(imageCover!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        printFullText(value.toString());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        // emit(SocialUploadProfileCoverSuccessState());
      }).catchError((error) {
        printFullText(error.toString());
        emit(SocialUploadProfileCoverErrorState());
      });
      printFullText(p0.toString());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialUploadProfileCoverErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final imagePost = await picker.pickImage(source: ImageSource.gallery);
    if (imagePost != null) {
      postImage = File(imagePost.path);
      emit(SocialGetCreatePostImageSuccessState());
    } else {
      printFullText('no enter cover');
      emit(SocialGetCreatePostImageErrorState());
    }
  }

  void uploadPostImage({
    required String dateTimePost,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        printFullText(value.toString());
        createPost(
          dateTimePost: dateTimePost,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        printFullText(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTimePost,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    SocialPostModel postModel = SocialPostModel(
      uID: model!.uID,
      name: model!.name,
      image: model!.image,
      datePost: dateTimePost,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<SocialPostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPost() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          postId.add(element.id);
        }).catchError((error) {
          printFullText(error.toString());
        });
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
        }).catchError((error) {});
      }
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uID)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialLikePostErrorState());
    });
  }

  List<int> comments = [];

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uID)
        .set({
      'comment': true,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialCommentPostErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    emit(SocialGetAllUserLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uID'] != model!.uID) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        printFullText(error.toString());
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
    String? messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      receiverID: receiverId,
      senderID: model!.uID,
      dataTime: dataTime,
      text: text,
      messageImage: messageImage ?? '',
    );
    // set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialGetMessageSuccessState());
    }).catchError((error) {
      emit(SocialGetMessageErrorState());
    });
    // set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }

  File? messageImage;

  Future<void> getMessageImage() async {
    final imageMessage = await picker.pickImage(source: ImageSource.gallery);
    if (imageMessage != null) {
      messageImage = File(imageMessage.path);
      emit(SocialGetMessageImageSuccessState());
    } else {
      printFullText('no enter cover');
      emit(SocialGetMessageImageErrorState());
    }
  }

  void uploadMessageImage({
    required String dateTimeMessage,
    required String text,
  }) {
    emit(SocialUploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        printFullText(value.toString());
        sendMessage(
          receiverId: model!.uID!,
          dataTime: dateTimeMessage,
          text: text,
        );
        emit(SocialUploadMessageImageSuccessState());
      }).catchError((error) {
        printFullText(error.toString());
        emit(SocialUploadMessageImageErrorState());
      });
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialUploadMessageImageErrorState());
    });
  }

  void removeMessageImage() {
    messageImage = null;
    emit(SocialRemoveMessageImageState());
  }
}
