import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

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
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: state is AppGetDataFromDatabaseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fibIcon),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (ctx) {
                          return Container(
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
                                          return 'Title must enter Data.';
                                        }
                                      },
                                      label: 'Task Title',
                                      iconPrefix: Icons.title,
                                      onSubmit: (value) {},
                                      suffixPress: () {},
                                      onChanged: (value) {},
                                      onTab: () {},
                                    ),
                                    const SizedBox(height: 15.0),
                                    defaultFormFieldF(
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Time must enter Data.';
                                        }
                                      },
                                      label: 'Task Time',
                                      iconPrefix: Icons.timer_sharp,
                                      onSubmit: (value) {},
                                      suffixPress: () {},
                                      onChanged: (value) {},
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
                                          return 'Date must enter Data.';
                                        }
                                      },
                                      label: 'Task Date',
                                      iconPrefix: Icons.date_range,
                                      onSubmit: (value) {},
                                      suffixPress: () {},
                                      onChanged: (value) {},
                                      onTab: () {
                                        dateShow(ctx);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        elevation: 1.0,
                      )
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(
                          isShow: false,
                          iconData: Icons.edit,
                        );
                      });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    iconData: Icons.add,
                  );
                }
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
}
