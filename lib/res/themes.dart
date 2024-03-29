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
    iconTheme: IconThemeData(color: white),
    actionsIconTheme: IconThemeData(color: white),
    titleTextStyle:
        TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  scaffoldBackgroundColor: black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff03fcb1),
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: darkGray),
  cardTheme: const CardTheme(color: darkGray),
  tabBarTheme: const TabBarTheme(labelColor: white),
  colorScheme: const ColorScheme.dark().copyWith(
    onPrimary: black,
    onSurface: darkGray,
    onPrimaryContainer: white,
  ),
  timePickerTheme: const TimePickerThemeData(
    dayPeriodTextColor: white,
    backgroundColor: darkGray,
    hourMinuteTextColor: white,
    dialBackgroundColor: black,
    dialTextColor: white,
    entryModeIconColor: white,
    helpTextStyle: TextStyle(color: white, fontWeight: FontWeight.bold),
  ),
  listTileTheme: const ListTileThemeData(tileColor: darkGray),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: darkGray,
    contentTextStyle: TextStyle(
      color: white,
    ),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      backgroundColor: lightGray,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: lightGray,
      ),
      titleTextStyle:
          TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20),
      iconTheme: IconThemeData(color: black)),
  scaffoldBackgroundColor: white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: lightGray,
  ),
  drawerTheme: const DrawerThemeData(backgroundColor: lightGray),
  tabBarTheme: const TabBarTheme(labelColor: black),
  colorScheme: const ColorScheme.dark().copyWith(
    onPrimary: white,
    onSurface: lightGray,
    onPrimaryContainer: black,
  ),
  timePickerTheme: const TimePickerThemeData(
    dayPeriodTextColor: black,
    backgroundColor: lightGray,
    hourMinuteTextColor: black,
    dialBackgroundColor: white,
    dialTextColor: black,
    entryModeIconColor: black,
    helpTextStyle: TextStyle(
      color: black,
      fontWeight: FontWeight.bold,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: lightGray,

  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: lightGray,
    contentTextStyle: TextStyle(
      color: black,
    ),
  ),

);
