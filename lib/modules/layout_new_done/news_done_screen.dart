import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';

class NewDone extends StatelessWidget {
  const NewDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newDone;
        return ListView.separated(
          itemBuilder: (context, index) => listTasksItem(tasks[index],context),
          separatorBuilder: (context, index) => Padding(
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
