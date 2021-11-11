import 'package:new_flutter2/models/shop_model/change_favorites.dart';
import 'package:new_flutter2/models/shop_model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  dynamic error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  dynamic error;

  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoriteModel changeFavoriteModel;

  ShopSuccessChangeFavoritesState(this.changeFavoriteModel);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  dynamic error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {
  dynamic error;

  ShopErrorGetFavoriteState(this.error);
}

class ShopLoadingGetUserState extends ShopStates {}

class ShopSuccessGetUserState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessGetUserState(this.userModel);
}

class ShopErrorGetUserState extends ShopStates {
  dynamic error;

  ShopErrorGetUserState(this.error);
}
