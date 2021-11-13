import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/models/shop_model/login_model.dart';
import 'package:new_flutter2/modules/shop_app/register/cubit/state.dart';
import 'package:new_flutter2/shared/network/end_points.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }

   ShopLoginModel? registerModel;

  void userRegister(
      {String? name, String? email, String? phone, String? password}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: registerR,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
