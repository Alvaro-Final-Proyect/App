import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPopup {
  static void show({
    required BuildContext context,
    String loadingText = '',
    TextStyle? textStyle,
  }) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, minHeight: 100),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${'textLoading'.tr}...',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
