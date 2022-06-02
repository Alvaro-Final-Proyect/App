import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/create_user_screen/create_user_controller.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import 'package:padel/widgets/expanded_button.dart';

class CreateUserBody extends StatelessWidget {
  CreateUserBody({Key? key}) : super(key: key);

  final _createUserController = Get.find<CreateUserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // USERNAME
          Input(
            controller: _createUserController.usernameInputController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            onChanged: (value) {
              _createUserController.usernameInputController.onChanged(value);
              _createUserController.usernameInputController.validate(
                  values: {'usernames': _createUserController.usernames});
            },
            label: 'textUsername'.tr,
          ),
          // EMAIL
          Input(
            controller: _createUserController.emailInputController,
            prefixIcon: const Icon(Icons.email),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.emailInputController.onChanged(value);
              _createUserController.emailInputController.validate(
                  values: {'emails': _createUserController.emails}
              );
            },
            label: 'textEmail'.tr,
          ),
          // PASSWORD
          Obx(() {
            return Input(
              controller: _createUserController.passwordInputController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              onChanged: (value) {
                _createUserController.passwordInputController.onChanged(value);
                _createUserController.passwordInputController.validate();
                _createUserController.repeatPasswordInputController.validate(
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
          // REPEAT PASSWORD
          Obx(() {
            return Input(
              controller: _createUserController.repeatPasswordInputController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              onChanged: (value) {
                _createUserController.repeatPasswordInputController
                    .onChanged(value);
                _createUserController.repeatPasswordInputController.validate(
                  values: {
                    'password':
                        _createUserController.passwordInputController.text,
                  },
                );
              },
              label: 'textRepeatPassword'.tr,
              suffixIcon: IconButton(
                onPressed: _createUserController
                    .repeatPasswordInputController.toggleVisibility,
                icon: Icon(
                  _createUserController.repeatPasswordInputController.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              obscureText: !_createUserController
                  .repeatPasswordInputController.isVisible,
            );
          }),
          // NAME
          Input(
            controller: _createUserController.nameInputController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.nameInputController.onChanged(value);
              _createUserController.nameInputController.validate();
            },
            label: 'textName'.tr,
          ),
          // SURNAME
          Input(
            controller: _createUserController.surnamePasswordController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.surnamePasswordController.onChanged(value);
              _createUserController.surnamePasswordController.validate();
            },
            label: 'textSurname'.tr,
          ),
          // IS ADMIN
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: CustomCheckbox(
              checkboxController: _createUserController.checkboxController,
              title: 'Is admin?',
            ),
          ),
          ExpandedButton(
            text: 'textCreateUser'.tr,
            onPressed: () {},
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
            padding: const EdgeInsets.all(20),
          )
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
