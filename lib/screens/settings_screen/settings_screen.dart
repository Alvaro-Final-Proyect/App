import 'dart:developer';

import 'package:padel/screens/settings_screen/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textSettings'.tr),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () async {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );

                settingsController.isDarkMode = !Get.isDarkMode;
                settingsController.saveTheme();
              },
              icon: Icon(
                settingsController.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: settingsController.isDarkMode ? darkYellow : lightYellow,
              ),
              tooltip: 'textChangeTheme'.tr,
            );
          }),
        ],
      ),
    );
  }
}