import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/social_layout.dart';
import 'package:new_flutter2/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:new_flutter2/modules/social_app/social_register_screen/cubit/cubit.dart';
import 'package:new_flutter2/shared/bloc_observer.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';
import 'package:new_flutter2/shared/cubits/state.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';
import 'package:new_flutter2/shared/network/remote/dio_helper.dart';
import 'package:new_flutter2/shared/styles/themes.dart';
import 'modules/social_app/social_login_screen/social_login_screen.dart';
import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      SocialCubit();
      SocialLoginCubit();
      SocialRegisterCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  /*bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  printFullText(token.toString());*/
/*  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
      if (token == null) {
        widget = const Center(
          child: CircularProgressIndicator(),
        );
      }
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }*/
  uid = CacheHelper.getData(key: 'uID');
  if (uid != null) {
    widget = const SocialLayout();
  } else {
    widget = const SocialLoginScreen();
  }

  runApp(
    MyApp(
      isDarkMode: isDark,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool? isDarkMode;
  final Widget startWidget;

  const MyApp({
    Key? key,
    required this.isDarkMode,
    required this.startWidget,
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
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPost()
            ..getUsers(),
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
            home: widget.startWidget,
          );
        },
      ),
    );
  }
}
