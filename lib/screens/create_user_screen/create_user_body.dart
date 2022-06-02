import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/create_user_screen/create_user_controller.dart';
import 'package:padel/util/input_validations/text_input_controller.dart';

class CreateUserBody extends StatelessWidget {
  CreateUserBody({Key? key}) : super(key: key);

  final _createUserController = Get.find<CreateUserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Input(
            controller: _createUserController.usernameInputController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            onChanged: (value) {
              _createUserController.usernameInputController.onChanged(value);
              _createUserController.usernameInputController.validate(
                  values: {'usernames': _createUserController.usernames});
            },
            label: 'textUsername'.tr,
          ),
          Obx(() {
            return Input(
              controller: _createUserController.passwordInputController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              onChanged: (value) {
                _createUserController.passwordInputController.onChanged(value);
                _createUserController.passwordInputController.validate();
                _createUserController.repeatPasswordController.validate(
                  values: {
                    'password':
                    _createUserController.passwordInputController.text,
                  },
                );
              },
              label: 'textPassword'.tr,
              suffixIcon: IconButton(
                onPressed: _createUserController
                    .passwordInputController.toggleVisibility,
                icon: Icon(
                  _createUserController.passwordInputController.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              obscureText:
                  !_createUserController.passwordInputController.isVisible,
            );
          }),
          Obx(() {
            return Input(
              controller: _createUserController.repeatPasswordController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              onChanged: (value) {
                _createUserController.repeatPasswordController.onChanged(value);
                _createUserController.repeatPasswordController.validate(
                  values: {
                    'password':
                        _createUserController.passwordInputController.text,
                  },
                );
              },
              label: 'textRepeatPassword'.tr,
              suffixIcon: IconButton(
                onPressed: _createUserController
                    .repeatPasswordController.toggleVisibility,
                icon: Icon(
                  _createUserController.repeatPasswordController.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              obscureText:
                  !_createUserController.repeatPasswordController.isVisible,
            );
          }),
        ],
      ),
    );
  }
}

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
  }) : super(key: key);

  final TextInputController? controller;
  final ValueChanged<String>? onChanged;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: TextFormField(
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
            errorText: controller?.error,
          ),
        ),
      );
    });
  }
}
