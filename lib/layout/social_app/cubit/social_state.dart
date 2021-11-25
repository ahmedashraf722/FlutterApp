abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

//Chat
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates {}

// messageImage

class SocialGetMessageImageSuccessState extends SocialStates {}

class SocialGetMessageImageErrorState extends SocialStates {}

class SocialRemoveMessageImageState extends SocialStates {}

// uploadMessageImage
class SocialUploadMessageImageLoadingState extends SocialStates {}

class SocialUploadMessageImageSuccessState extends SocialStates {}

class SocialUploadMessageImageErrorState extends SocialStates {}

//Get Post
class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickerSuccessState extends SocialStates {}

class SocialProfileImagePickerErrorState extends SocialStates {}

class SocialUploadProfileImagePickerSuccessState extends SocialStates {}

class SocialUploadProfileImagePickerErrorState extends SocialStates {}

class SocialProfileCoverSuccessState extends SocialStates {}

class SocialProfileCoverErrorState extends SocialStates {}

class SocialUploadProfileCoverSuccessState extends SocialStates {}

class SocialUploadProfileCoverErrorState extends SocialStates {}

class SocialUpdateProfileLoadingState extends SocialStates {}

class SocialUpdateProfileErrorState extends SocialStates {}

//create post
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialGetCreatePostImageSuccessState extends SocialStates {}

class SocialGetCreatePostImageErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//Like Post

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

//Comment

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {}
