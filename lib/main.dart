import 'package:flutter/material.dart';
import 'package:new_flutter2/responsive_adaptive_app/desktop.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/responsive_adaptive_app/mobile.dart';
import 'package:new_flutter2/shared/styles/themes.dart';

/*

// onBackground FCM
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printFullText('Messaging on Background Handler');
  printFullText(message.data.toString());
  showToast(
    message: 'Messaging on Background Handler',
    state: ToastState.success,
  );
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //set minimum width and height on app
  /*if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(600.0, 400.0));
  }*/

  // DioHelper.init();
  //  await CacheHelper.init();
  //bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(
    const MyApp(
        //  isDarkMode: isDark,
        // startWidget: widget,
        ),
  );
  /* await Firebase.initializeApp();
  var tokenM = await FirebaseMessaging.instance.getToken();
  printFullText(tokenM.toString());

  // Foreground Fcm
  FirebaseMessaging.onMessage.listen((event) {
    printFullText('onMessage');
    printFullText(event.data.toString());
    showToast(
      message: 'onMessage',
      state: ToastState.success,
    );
  });*/
/*
  //When click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    printFullText('onMessageOpenedApp');
    printFullText(event.data.toString());
    showToast(
      message: 'onMessageOpenedApp',
      state: ToastState.success,
    );
  });*/

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

/*  BlocOverrides.runZoned(
    () {
      */ /* SocialCubit();
      SocialLoginCubit();
      SocialRegisterCubit();*/ /*
    },
    blocObserver: MyBlocObserver(),
  );*/

  //Widget widget;
  //bool? isDark = CacheHelper.getData(key: 'isDark');

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

  /* uid = CacheHelper.getData(key: 'uID');
  if (uid != null) {
    widget = const SocialLayout();
  } else {
    widget = const SocialLoginScreen();
  }
*/
}

class MyApp extends StatefulWidget {
  // final bool? isDarkMode;

  // final Widget startWidget;

  const MyApp({
    Key? key,
    // required this.isDarkMode,
    //required this.startWidget,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          printFullText(getOs());
          if (constraints.minWidth.toInt() <= 550) {
            return const MobileScreen();
          } else {
            return const DesktopScreen();
          }
        },
      ),
    );
    /*  return MultiBlocProvider(
      providers: [
       */ /* BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),*/ /*
       */ /* BlocProvider(
          create: (context) =>
              AppCubit()..changeAppMode(fromShared: widget.isDarkMode),
        ),*/ /*

        */ /*    BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getUserData(),
        ),*/ /*

        */ /*BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPost(),
        ),*/ /*
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
         // var cubit = AppCubit.get(context);
          return MaterialApp(
            themeMode: ThemeMode.light,// cubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const NewsApp(),
          );
        },
      ),
    );*/
  }
}
