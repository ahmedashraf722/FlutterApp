import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/modules/layout_new_archived/news_archived_screen.dart';
import 'package:new_flutter2/modules/layout_new_done/news_done_screen.dart';
import 'package:new_flutter2/modules/layout_new_tasks/new_tasks_screen.dart';
import 'package:new_flutter2/shared/cubits/state.dart';
import 'package:sqflite/sqflite.dart';

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

  bool isBottomSheetShown = false;

  IconData fibIcon = Icons.edit;

  void changeBottomSheetState(
      {required bool isShow, required IconData iconData}) {
    isBottomSheetShown = isShow;
    fibIcon = iconData;
    emit(AppChangeBottomSheetState());
  }

  late Database database;
  List<Map> tasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, '
                'title TEXT, date TEXT ,time TEXT, state TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataFromDatabaseState());
        });
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    String? title,
    String? date,
    String? time,
    String? state,
  }) async {
    await database
        .rawInsert(
            'INSERT INTO tasks (title,date,time,state) VALUES("$title","$date","$time","$state")')
        .then((value) {
      print('$value inserted successfully');
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDataFromDatabaseState());
      });
    }).catchError((error) {
      print('error when inserting New Record ${error.toString()}');
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    emit(AppGetDataFromDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
    //print(task.toString());
  }
}
