import 'dart:developer';

import 'package:padel/screens/login_screen/login_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import 'package:padel/widgets/custom_text_field.dart';
import 'package:padel/widgets/expanded_button.dart';
import 'package:padel/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_password_field.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('loginTitle'.tr),
        centerTitle: true,
      ),
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: MobileBody(),
      desktopBody: DesktopBody()
    );
  }
}

class DesktopBody extends StatelessWidget {
  DesktopBody({Key? key}) : super(key: key);

  final _loginController = Get.find<LoginController>();
  final username = CustomTextField(
      labelText: 'textUsernameOrEmail',
      icon: Icons.person,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      validator: (customTextFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customTextFieldController.textError;
        bool result = false;

        if(text.isBlank?? true){
          textError.value = 'This field cant be empty';
        }else {
          textError.value = '';
          result = true;
        }

        return result;
      }
  );
  final password = CustomPasswordField(
      labelText: 'textPassword',
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      validator: (customPasswordFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customPasswordFieldController.textError;
        bool result = false;

        if(text.isBlank?? true){
          textError.value = 'Password cant be empty';
        }else {
          textError.value = '';
          result = true;
        }

        return result;
      }
  );
  final checkboxController = CheckboxController();
  void _login() async {
    final usernameValidation = username.validator(username.customTextFieldController, username.textEditingController);
    final passwordValidation = password.validator(password.customPasswordFieldController, password.textEditingController);

    if(!usernameValidation || !passwordValidation) {
      return;
    }

    await _loginController.login(
        username.textEditingController.text,
        password.textEditingController.text,
        checkboxController.isChecked.value
    );

    if (_loginController.loadError() == '') {
      Get.offAllNamed('/home');
    } else {
      log('error');
      Fluttertoast.showToast(
        msg: _loginController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset('assets/raqueta-de-padel.png', fit: BoxFit.contain,),
          )
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'HELLO AGAIN',
                      style: GoogleFonts.bebasNeue(fontSize: 52)
                  ),
                  const Text(
                      'Welcome back, you\'ve been missed!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                  ),
                  username,
                  password,
                  CustomCheckbox(
                    checkboxController: checkboxController,
                    title: 'textKeepMeLogged',
                  ),
                  ExpandedButton(
                    text: 'loginTitle'.tr,
                    onPressed: _login,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () => Get.toNamed('/register'),
                          child: const Text(
                            'Register now!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          flex: 2,
        )
      ],
    );
  }
}

class MobileBody extends StatelessWidget {
  MobileBody({Key? key}) : super(key: key);

  final _loginController = Get.find<LoginController>();
  final username = CustomTextField(
    labelText: 'textUsernameOrEmail',
    icon: Icons.person,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    validator: (customTextFieldController, textEditingController) {
      final String text = textEditingController.text;
      final RxString textError = customTextFieldController.textError;
      bool result = false;

      if(text.isBlank?? true){
        textError.value = 'This field cant be empty';
      }else {
        textError.value = '';
        result = true;
      }

      return result;
    }
  );
  final password = CustomPasswordField(
      labelText: 'textPassword',
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      validator: (customPasswordFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customPasswordFieldController.textError;
        bool result = false;

        if(text.isBlank?? true){
          textError.value = 'Password cant be empty';
        }else {
          textError.value = '';
          result = true;
        }

        return result;
      }
  );
  final checkboxController = CheckboxController();
  void _login() async {
    final usernameValidation = username.validator(username.customTextFieldController, username.textEditingController);
    final passwordValidation = password.validator(password.customPasswordFieldController, password.textEditingController);

    if(!usernameValidation || !passwordValidation) {
      return;
    }

    await _loginController.login(
        username.textEditingController.text,
        password.textEditingController.text,
        checkboxController.isChecked.value
    );

    if (_loginController.loadError() == '') {
      Get.offAllNamed('/home');
    } else {
      Fluttertoast.showToast(
        msg: _loginController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                    height: 200,
                    width: 200,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/raqueta-de-padel.png', fit: BoxFit.contain,),
                  ),
                  flex: 1
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'HELLO AGAIN',
                            style: GoogleFonts.bebasNeue(fontSize: 52)
                        ),
                        const Text(
                            'Welcome back, you\'ve been missed!',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                        ),
                        const SizedBox(height: 20,),
                        username,
                        password,
                        CustomCheckbox(
                          checkboxController: checkboxController,
                          title: 'textKeepMeLogged',
                        ),
                        ExpandedButton(
                          text: 'loginTitle'.tr,
                          onPressed: _login,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(20),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Not a member?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed('/register'),
                              child: const Text(
                                'Register now!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                flex: 3,
              )
            ],
          ),
        )
      ],
    );
  }
}