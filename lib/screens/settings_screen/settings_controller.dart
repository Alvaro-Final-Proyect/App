import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _isDarkMode = Get.isDarkMode.obs;
  set isDarkMode(value) => _isDarkMode.value = value;
  bool get isDarkMode => _isDarkMode.value;
}