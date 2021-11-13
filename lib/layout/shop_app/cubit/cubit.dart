import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/categories_model.dart';
import 'package:new_flutter2/models/shop_model/change_favorites.dart';
import 'package:new_flutter2/models/shop_model/favorites_model.dart';
import 'package:new_flutter2/models/shop_model/home_model.dart';
import 'package:new_flutter2/models/shop_model/login_model.dart';
import 'package:new_flutter2/modules/shop_app/categories_screen/categories_screen.dart';
import 'package:new_flutter2/modules/shop_app/favourite_screen/favourite_screen.dart';
import 'package:new_flutter2/modules/shop_app/product_screen/product_screen.dart';
import 'package:new_flutter2/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/network/end_points.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  List titles = const [
    'Product',
    'Categories',
    'Favourite',
    'Settings',
  ];
  List screens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Product',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favourite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel!.data!.products[1].name.toString());
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      }
      //print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: categories,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: favoritesF,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      // print(value.data.toString());
      if (!changeFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoriteData() {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: favoritesF,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriteState(error));
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserState());
    DioHelper.getData(
      url: profileP,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessGetUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserState(error));
    });
  }

  void updateUserData({
    String? name,
    String? email,
    String? phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState(error));
    });
  }
}
