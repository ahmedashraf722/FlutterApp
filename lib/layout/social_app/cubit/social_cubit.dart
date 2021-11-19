import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
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

  void updateUserImages({
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
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
  }) {
    SocialUserModel modelUser = SocialUserModel(
      uID: model!.uID,
      name: name,
      phone: phone,
      bio: bio,
      image: model!.image,
      cover: model!.cover,
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

  File? image;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      printFullText(image!.path.toString());
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

  String? profileImageUrl;

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        printFullText(value.toString());

        emit(SocialUploadProfileImagePickerSuccessState());
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

  String? profileImageCoverUrl;

  void uploadProfileImageCover() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageCover!.path).pathSegments.last}')
        .putFile(imageCover!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        profileImageCoverUrl = value;
        printFullText(value.toString());

        emit(SocialUploadProfileCoverSuccessState());
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
}
