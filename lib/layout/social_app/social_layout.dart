import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        //var model = SocialCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex].toString()),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
              defaultTextButton(
                function: () {
                  navigateAndFinish(context, const SocialLoginScreen());
                },
                text: 'logout',
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.bottomNavigationBarItem,
          ),
          body: cubit.model == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
