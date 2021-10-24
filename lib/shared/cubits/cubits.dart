import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/modules/layout_new_archived/news_archived_screen.dart';
import 'package:new_flutter2/modules/layout_new_done/news_done_screen.dart';
import 'package:new_flutter2/modules/layout_new_tasks/new_tasks_screen.dart';
import 'package:new_flutter2/shared/cubits/state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List screens = [
    const NewTasks(),
    const NewDone(),
    const NewArchived(),
  ];

  List titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
