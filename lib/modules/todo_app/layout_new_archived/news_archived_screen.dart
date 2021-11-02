import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';

class NewArchived extends StatelessWidget {
  const NewArchived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit
            .get(context)
            .newArchived;
        return tasks.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.archive,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Text(
                'no Archived yet ,please entered',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
            : ListView.separated(
          itemBuilder: (context, index) =>
              listTasksItem(tasks[index], context),
          separatorBuilder: (context, index) =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
