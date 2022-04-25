
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/constantes.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'jannah',
  inputDecorationTheme: InputDecorationTheme(
    iconColor: Colors.white,
    labelStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'jannah',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    elevation: 30,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      height: 1.3,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      height: 1.3,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  fontFamily: 'jannah',
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'jannah',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    //selectedItemColor: HexColor('333739'),
    elevation: 30,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      height: 1.3,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      height: 1.3,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);