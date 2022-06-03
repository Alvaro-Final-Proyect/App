import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.controller,
    this.onChanged,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.obscureText = false,
    this.initialValue,
  }) : super(key: key);

  final TextInputController? controller;
  final ValueChanged<String>? onChanged;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final bool obscureText;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return GetX<TextInputController>(
      init: controller ?? TextInputController(),
      builder: (controller) {
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 3.0,
                ),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              errorText: controller.error,
            ),
          ),
        );
      },
    );
  }
}