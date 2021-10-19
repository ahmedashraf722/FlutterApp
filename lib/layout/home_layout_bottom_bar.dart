import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/layout_new_archived/news_archived_screen.dart';
import 'package:new_flutter2/modules/layout_new_done/news_done_screen.dart';
import 'package:new_flutter2/modules/layout_new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  List screens = [
    const NewTasks(),
    const NewDone(),
    const NewArchived(),
  ];
  List titles = [
    'New Tasks',
    'Done Task',
    'Archived Task',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        centerTitle: true,
      ),
      body: screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          /* try {
            var name = await getName();
            print(name);
            //throw('some error ----');

          } catch (error) {
            print('error ${error.toString()}');
          }*/
          getName().then((value) {
            print(value);
            print('Serga');
           // throw ('انا عملت ايرور!!!');
          }).catchError((error) {
            print('error ${error.toString()}');
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.orange,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
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
  }

  Future<String> getName() async {
    return 'Ahmed Ashraf';
  }
}
