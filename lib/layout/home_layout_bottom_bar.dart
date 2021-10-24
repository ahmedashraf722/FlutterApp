import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter2/modules/layout_new_archived/news_archived_screen.dart';
import 'package:new_flutter2/modules/layout_new_done/news_done_screen.dart';
import 'package:new_flutter2/modules/layout_new_tasks/new_tasks_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var stateController = TextEditingController();

  late Database database;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  bool isBottomSheetShown = false;

  IconData fibIcon = Icons.edit;

  void timeShow(BuildContext ctx) {
    showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      timeController.text = value!.format(ctx).toString();
      //print(value!.format(ctx));
    });
  }

  void dateShow(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.parse('2022-10-22'),
    ).then((value) {
      dateController.text = DateFormat.yMMMd().format(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: /*tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                :*/
                cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(fibIcon),
              onPressed: () {
                if (isBottomSheetShown) {
                  Navigator.pop(context);
                  isBottomSheetShown = false;
                  /* setState(() {
              fibIcon = Icons.edit;
            });*/
                } else {
                  /* isBottomSheetShown = true;
            setState(() {
              fibIcon = Icons.add;
            });*/
                  scaffoldKey.currentState!.showBottomSheet(
                    (ctx) {
                      return Container(
                        //color: Colors.white,
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormFieldF(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Title must entered.';
                                    }
                                  },
                                  label: 'Task Title',
                                  iconPrefix: Icons.title,
                                  onSubmit: () {},
                                  suffixPress: () {},
                                  onChanged: () {},
                                  onTab: () {},
                                ),
                                const SizedBox(height: 15.0),
                                defaultFormFieldF(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Time must entered.';
                                    }
                                  },
                                  label: 'Task Time',
                                  iconPrefix: Icons.timer_sharp,
                                  onSubmit: () {},
                                  suffixPress: () {},
                                  onChanged: () {},
                                  onTab: () {
                                    timeShow(ctx);
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                defaultFormFieldF(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Date must entered.';
                                    }
                                  },
                                  label: 'Task Date',
                                  iconPrefix: Icons.date_range,
                                  onSubmit: () {},
                                  suffixPress: () {},
                                  onChanged: () {},
                                  onTab: () {
                                    dateShow(ctx);
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                defaultFormFieldF(
                                  controller: stateController,
                                  type: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'State must entered.';
                                    }
                                  },
                                  label: 'Task State',
                                  iconPrefix: Icons.question_answer,
                                  onSubmit: () {},
                                  suffixPress: () {},
                                  onChanged: () {},
                                  onTab: () {},
                                ),
                                const SizedBox(height: 15.0),
                                MaterialButton(
                                  color: Colors.blue,
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (!formKey.currentState!.validate()) {
                                      '';
                                    } else {
                                      /*  setState(() {});
                                insertToDatabase(
                                  title: titleController.text,
                                  time: timeController.text,
                                  date: dateController.text,
                                  state: stateController.text,
                                ).then((value) {
                                  getDataFromDatabase(database).then((value) {
                                    Navigator.pop(context);
                                    setState(() {
                                      tasks = value;
                                    });
                                    print(tasks);
                                  });
                                });*/
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    elevation: 1.0,
                  );
                }
                //insertToDatabase();
                /* try {
            var name = await getName();
            print(name);
            //throw('some error ----');

          } catch (error) {
            print('error ${error.toString()}');
          }*/
                // getName().then((value) {
                //   print(value);
                //   print('Serga');
                //   // throw ('انا عملت ايرور!!!');
                // }).catchError((error) {
                //   print('error ${error.toString()}');
                // });
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              //backgroundColor: Colors.orange,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Task',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future createDatabase() async {
    database = await openDatabase(
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
          /*setState(() {
            tasks = value;
          });*/
          print(tasks);
        });
      },
    );
  }

  Future insertToDatabase({
    String? title,
    String? date,
    String? time,
    String? state,
  }) async {
    return await database
        .rawInsert(
            'INSERT INTO tasks (title,date,time,state) VALUES("$title","$date","$time","$state")')
        .then((value) {
      print('$value inserted successfully');
    }).catchError((error) {
      print('error when inserting New Record ${error.toString()}');
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
    //print(task.toString());
  }
}
