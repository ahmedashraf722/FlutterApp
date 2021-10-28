import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/states.dart';
import 'package:new_flutter2/modules/news_app_modules/business/business_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/science/science_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/settings_screen/settings_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/sports/sports_screen.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeIndexBottom(int index) {
    currentIndex = index;
   /* if (currentIndex == 1) {
      getSports();
    }
    if (currentIndex == 2) {
      getScience();
    }*/
    emit(NewsChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '25c922b157134d0aadefaa4453b13530',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business[5]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '25c922b157134d0aadefaa4453b13530',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[5]);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetSportsLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '25c922b157134d0aadefaa4453b13530',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[5]);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
