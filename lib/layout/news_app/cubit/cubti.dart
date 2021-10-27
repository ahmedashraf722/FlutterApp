import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/states.dart';
import 'package:new_flutter2/modules/news_app_modules/business/business_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/science/science_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/settings_screen/settings_screen.dart';
import 'package:new_flutter2/modules/news_app_modules/sports/sports_screen.dart';

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
    emit(NewsChangeBottomNavBarState());
  }
}
