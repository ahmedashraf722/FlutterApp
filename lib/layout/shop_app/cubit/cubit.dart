import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/categories_model.dart';
import 'package:new_flutter2/models/shop_model/home_model.dart';
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

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.products[1].name.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    });
  }
}
