import 'package:new_flutter2/models/shop_model/login_model.dart';

abstract class RegisterStates {}

class ShopRegisterInitialState extends RegisterStates {}

class ShopRegisterChangeVisibilityState extends RegisterStates {}

class ShopRegisterLoadingState extends RegisterStates {}

class ShopRegisterSuccessState extends RegisterStates {
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends RegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}
