import 'dart:io';
import 'package:flutter/services.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/core/shared_preferences_helper.dart';
import 'package:padel/pages.dart';
import 'package:padel/res/colors.dart';
import 'package:padel/res/themes.dart';
import 'package:padel/screens/home_screen/home_page.dart';
import 'package:padel/screens/login_screen/login_page.dart';
import 'package:padel/util/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // With this we load an instance of SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelper.setSharedPreferences(await SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Method that checks the token on shared preferences and returns the HomePage
  // or the LoginPage
  Widget loadFirstPage() {
    String? token = SharedPreferencesHelper.sharedPreferences.getString('token');
    if(token != null && token != ''){
      RetrofitHelper.setToken(token);
      return HomePage();
    }

    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    // With this we init the retrofit helper
    RetrofitHelper();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pages,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: loadFirstPage(),
      translations: Messages(),
      locale: Locale(Platform.localeName),
      fallbackLocale: const Locale('en_US'),
    );
  }
}
