import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/res/colors.dart';

class CheckboxController extends GetxController {
  CheckboxController({bool initial = false}){
    isChecked = initial.obs;
  }

  late Rx<bool> isChecked;
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
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          title: Text(title.tr),
          value: checkboxController.isChecked.value,
          onChanged: (value) => checkboxController.toggleCheck(value ?? false),
          tileColor: Get.isDarkMode ? black : white,
        );
      },
    );
  }
}
