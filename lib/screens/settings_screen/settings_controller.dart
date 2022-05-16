import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final _isDarkMode = Get.isDarkMode.obs;
  set isDarkMode(value) => _isDarkMode.value = value;
  bool get isDarkMode => _isDarkMode.value;

  void saveTheme() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isDarkMode', isDarkMode);
  }
}