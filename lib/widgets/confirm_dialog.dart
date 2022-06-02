import 'package:flutter/material.dart';
import 'package:get/get.dart';

void defaultCancel() => Get.back();

class ConfirmDialog {
  static void show(
    BuildContext context, {
    required VoidCallback? onContinue,
    VoidCallback? onCancel = defaultCancel,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('textSaveSettings'.tr),
          content: Text('textAreYouSureSaveSettings'.tr),
          actions: [
            _cancelButton(onCancel),
            _continueButton(onContinue),
          ],
        );
      },
    );
  }

  static Widget _continueButton(VoidCallback? callback) {
    return TextButton(
      onPressed: callback,
      child: Text('textContinue'.tr),
    );
  }

  static Widget _cancelButton(VoidCallback? callback) {
    return TextButton(
      onPressed: callback,
      child: Text('textCancel'.tr),
    );
  }
}
