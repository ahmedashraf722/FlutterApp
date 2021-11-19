import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/models/social_model/social_user_model.dart';
import 'package:new_flutter2/modules/social_app/social_register_screen/cubit/state.dart';
import 'package:new_flutter2/shared/components/constants.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(BuildContext context) =>
      BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangeVisibilityState());
  }

  void createUser({
    required String uID,
    required String name,
    required String email,
    required String phone,
    //required String image,
  }) {
    SocialUserModel model = SocialUserModel(
      uID: uID,
      name: name,
      email: email,
      phone: phone,
      image: 'https://images.unsplash.com/photo-1476234251651-f353703a034d?ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
      cover: 'https://images.unsplash.com/photo-1472162072942-cd5147eb3902?ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
      bio: 'write your bio...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      printFullText(value.user!.email!.toString());
      printFullText(value.user!.uid.toString());
      createUser(
        uID: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error) {
      printFullText(error.toString());
      emit(SocialRegisterErrorState(error));
    });
  }
}
