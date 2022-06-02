import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/core/shared_preferences_helper.dart';
import 'package:padel/pages.dart';
import 'package:padel/res/themes.dart';
import 'package:padel/screens/home_screen/home_page.dart';
import 'package:padel/screens/login_screen/login_page.dart';
import 'package:padel/screens/splash_screen/splash_screen.dart';
import 'package:padel/util/internationalization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.setSharedPreferences(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RetrofitHelper();
    bool isDarkMode = SharedPreferencesHelper.sharedPreferences.getBool('isDarkMode')
        ?? SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pages,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
      translations: Messages(),
      locale: Locale(Platform.localeName),
      fallbackLocale: const Locale('en_US'),
    );
  }
}
