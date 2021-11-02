import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_flutter2/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  fontFamily: 'Cairo',
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 25.0,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  fontFamily: 'Cairo',
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 25.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
);
