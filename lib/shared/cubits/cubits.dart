import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/modules/todo_app/layout_new_archived/news_archived_screen.dart';
import 'package:new_flutter2/modules/todo_app/layout_new_done/news_done_screen.dart';
import 'package:new_flutter2/modules/todo_app/layout_new_tasks/new_tasks_screen.dart';
import 'package:new_flutter2/shared/cubits/state.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';
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
  List<Map> newTasks = [];
  List<Map> newDone = [];
  List<Map> newArchived = [];

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
        getDataFromDatabase(database);
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
  }) async {
    await database
        .rawInsert(
            'INSERT INTO tasks (title,date,time,state) VALUES("$title","$date","$time","new")')
        .then((value) {
      print('$value inserted successfully');
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      print('error when inserting New Record ${error.toString()}');
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    newDone = [];
    newArchived = [];

    emit(AppGetDataFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['state'] == 'new') {
          newTasks.add(element);
        } else if (element['state'] == 'done') {
          newDone.add(element);
        } else {
          newArchived.add(element);
        }
        print(element['state']);
      }
      emit(AppGetDataFromDatabaseState());
    });
    //print(task.toString());
  }

  void updateData({
    String? status,
    int? id,
  }) async {
    database.rawUpdate('UPDATE tasks SET state = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({int? id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataFromDatabaseState());
    });
  }

  bool isDarkMode = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(AppChangeModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper.putBoolData(key: 'isDark', value: isDarkMode).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
