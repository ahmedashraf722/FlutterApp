import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/news_app/cubit/states.dart';
import 'package:new_flutter2/modules/news_app/search/search_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigatorTo(context, const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
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
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndexBottom(index);
            },
            items: cubit.bottomNavigationBarItem,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
