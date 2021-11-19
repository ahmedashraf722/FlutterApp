abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
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
