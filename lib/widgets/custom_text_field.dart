import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef CustomTextFieldValidator = bool Function(
  CustomTextFieldController customTextFieldController,
  TextEditingController textEditingController,
);

class CustomTextFieldController extends GetxController {
  var textError = ''.obs;
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.validator,
    required this.labelText,
    this.icon,
    this.margin = EdgeInsets.zero
  }) : super(key: key);

  final CustomTextFieldController customTextFieldController = CustomTextFieldController();
  final CustomTextFieldValidator validator;
  final TextEditingController textEditingController = TextEditingController();
  final String labelText;
  final IconData? icon;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: margin,
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: labelText.tr,
            border: const OutlineInputBorder(),
            prefixIcon: icon != null ? Icon(icon) : null,
            errorText: customTextFieldController.textError.value == '' ? null : customTextFieldController.textError.value
          )
        ),
      );
    });
  }
}