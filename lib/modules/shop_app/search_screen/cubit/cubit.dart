import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/models/shop_model/search_model.dart';
import 'package:new_flutter2/modules/shop_app/search_screen/cubit/state.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/network/end_points.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(BuildContext context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchData({String? text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: searchS,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.status.toString());
    //  print(searchModel!.data!.data.toString());
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState(error));
    });
  }
}
