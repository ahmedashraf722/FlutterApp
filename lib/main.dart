import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';
import 'package:new_flutter2/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:new_flutter2/shared/bloc_observer.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';
import 'package:new_flutter2/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  runApp(MyApp(isDarkMode: isDark));
}

class MyApp extends StatefulWidget {
  final bool? isDarkMode;

  const MyApp({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) =>
              AppCubit()..changeAppMode(fromShared: widget.isDarkMode),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            themeMode: cubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
