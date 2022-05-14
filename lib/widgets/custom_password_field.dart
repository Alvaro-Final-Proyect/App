import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef CustomPasswordFieldValidator = bool Function(
    CustomPasswordFieldController customPasswordFieldController,
    TextEditingController textEditingController
);

class CustomPasswordFieldController extends GetxController {
  CustomPasswordFieldController();

  var textError = ''.obs;
  var isHidden = true.obs;

  toggleVisibility() => isHidden.value = !isHidden.value;
}

class CustomPasswordField extends StatelessWidget {
  CustomPasswordField({
    Key? key,
    required this.validator,
    required this.labelText,
    this.margin = EdgeInsets.zero
  }) : super(key: key);

  final CustomPasswordFieldController customPasswordFieldController =
      CustomPasswordFieldController();
  final CustomPasswordFieldValidator validator;
  final TextEditingController textEditingController = TextEditingController();
  final String labelText;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: margin,
        child: TextFormField(
          obscureText: customPasswordFieldController.isHidden.value,
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: labelText.tr,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: customPasswordFieldController.toggleVisibility,
              icon: Icon(customPasswordFieldController.isHidden.value
                ? Icons.visibility_off
                : Icons.visibility
              )
            ),
            errorText: customPasswordFieldController.textError.value == ''
              ? null
              : customPasswordFieldController.textError.value
          )
        )
      );
    });
  }
}