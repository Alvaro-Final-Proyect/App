import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/login_screen/login_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import 'package:padel/widgets/custom_text_field.dart';
import 'package:padel/widgets/loading_popup.dart';

import '../../widgets/custom_password_field.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padel IT'.tr),
        centerTitle: true,
      ),
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);

  final _loginController = Get.find<LoginController>();
  final username = CustomTextField(
      labelText: 'textUsernameOrEmail',
      icon: Icons.person,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      validator: (customTextFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customTextFieldController.textError;
        bool result = false;

        if (text.isBlank ?? true) {
          textError.value = 'This field cant be empty';
        } else {
          textError.value = '';
          result = true;
        }

        return result;
      });
  final password = CustomPasswordField(
      labelText: 'textPassword',
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      validator: (customPasswordFieldController, textEditingController, _) {
        final String text = textEditingController.text;
        final RxString textError = customPasswordFieldController.textError;
        bool result = false;

        if (text.isBlank ?? true) {
          textError.value = 'Password cant be empty';
        } else {
          textError.value = '';
          result = true;
        }

        return result;
      });
  final checkboxController = CheckboxController();

  _login(context) async {
    final usernameValidation = username.validator(
        username.customTextFieldController, username.textEditingController);
    final passwordValidation = password.validator(
        password.customPasswordFieldController,
        password.textEditingController,
        null);

    if (!usernameValidation || !passwordValidation) {
      return;
    }

    await _loginController
        .login(
          username.textEditingController.text,
          password.textEditingController.text,
          checkboxController.isChecked.value,
        )
        .then(
          (value) => {
            if (_loginController.loadError() == '')
              {Get.offAllNamed('/home')}
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _loginController.loadError(),
                    ),
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 0, 40),
                    child: Text(
                      'loginTitle'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  username,
                  password,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                    child: CustomCheckbox(
                      checkboxController: checkboxController,
                      title: 'textKeepMeLogged',
                    ),
                  ),
                ],
              ),
            ),
            // FOOTER
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        LoadingPopup.show(context: context, loadingText: 'Loading...');
                        await _login(context);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'loginTitle'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            'textDontHaveAccount'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () => Get.toNamed('/register'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
