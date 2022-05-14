import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkGray,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: darkGray,
    ),
  ),
  scaffoldBackgroundColor: black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff03fcb1),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: darkGray
  ),
  cardTheme: const CardTheme(
    color: darkGray
  )
);

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: lightGray,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: lightGray,
    ),
    titleTextStyle: TextStyle(
      color: black,
      fontWeight: FontWeight.bold,
      fontSize: 20
    ),
    iconTheme: IconThemeData(
      color: black
    )
  ),
  scaffoldBackgroundColor: white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff00b0fd),
  ),
  drawerTheme: const DrawerThemeData(
      backgroundColor: lightGray
  ),
);