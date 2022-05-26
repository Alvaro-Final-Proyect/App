import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/res/colors.dart';

class CheckboxController extends GetxController {
  var isChecked = false.obs;

  void toggleCheck(bool value) => isChecked.value = value;
}

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {Key? key, required this.checkboxController, required this.title})
      : super(key: key);
  final CheckboxController checkboxController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CheckboxListTile(
          title: Text(title.tr),
          value: checkboxController.isChecked.value,
          onChanged: (value) => checkboxController.toggleCheck(value ?? false),
          tileColor: Get.isDarkMode ? black : white,
        );
      },
    );
  }
}
