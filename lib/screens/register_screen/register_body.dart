import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:padel/screens/register_screen/register_controller.dart';
import 'package:padel/widgets/input.dart';
import 'package:padel/widgets/loading_popup.dart';

import '../../widgets/custom_password_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/expanded_button.dart';

class GenderController {
  String gender = 'male';
}

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  bool validateFields() {

    final validations = [
      _registerController.usernameController.validate(values: {'usernames': _registerController.usernames}),
      _registerController.emailController.validate(values: {'emails': _registerController.emails}),
      _registerController.passwordController.validate(),
      _registerController.repeatPasswordController.validate(values: {'password': _registerController.passwordController.text}),
      _registerController.nameController.validate(),
      _registerController.surnameController.validate(),
      level.validator(level.dropDownMenuController),
      position.validator(position.dropDownMenuController),
    ];

    return !validations.contains(false);
  }

  void _register(BuildContext context) async {
    if (validateFields()) {
      LoadingPopup.show(context: context);

      _registerController
          .register(
        username: _registerController.usernameController.text,
        email: _registerController.emailController.text,
        password: _registerController.passwordController.text,
        name: _registerController.nameController.text,
        surname: _registerController.surnameController.text,
        level: level.dropDownMenuController.selected.value,
        position: position.dropDownMenuController.selectedValue,
        gender: genderController.gender,
      )
          .then(
        (value) {
          Get.back();

          if (_registerController.loadError() == '') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'User registered correctly',
                ),
              ),
            );

            Get.back();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Username or email repeated',
                ),
              ),
            );
          }
        },
      );
    }
  }

  final RegisterController _registerController = Get.find();
  final GenderController genderController = GenderController();
  final level = DropdownMenu(
    items: const <String>['1.50', '2.00', '2.50', '3.00', '3.50', '4.00'],
    hint: 'textSelectYourLevel',
    validator: (dropdownMenuController) {
      final String selected = dropdownMenuController.selected.value;
      final RxString textError = dropdownMenuController.textError;
      bool result = false;

      if (selected.isEmpty) {
        textError.value = 'You have to select a level';
      } else {
        textError.value = '';
        result = true;
      }

      return result;
    },
  );
  final position = DropdownMenu(
    items: const <String>[
      'textRightPosition',
      'textBackhandPosition',
      'textIndifferentPosition'
    ],
    hint: 'textSelectYourPosition',
    validator: (dropdownMenuController) {
      final String selected = dropdownMenuController.selected.value;
      final RxString textError = dropdownMenuController.textError;
      bool result = false;

      if (selected.isEmpty) {
        textError.value = 'You have to select a position';
      } else {
        textError.value = '';
        result = true;
      }

      return result;
    },
  );

  @override
  Widget build(BuildContext context) {
    final usernameController = _registerController.usernameController;
    final emailController = _registerController.emailController;
    final passwordController = _registerController.passwordController;
    final repeatPasswordController = _registerController.repeatPasswordController;
    final nameController = _registerController.nameController;
    final surnameController = _registerController.surnameController;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Input(
                label: 'textUsername'.tr,
                prefixIcon: const Icon(Icons.person),
                controller: usernameController,
                onChanged: (value) {
                  usernameController.onChanged(value);
                  usernameController.validate(values: {'usernames' : _registerController.usernames});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Input(
                label: 'textEmail'.tr,
                prefixIcon: const Icon(Icons.email),
                controller: emailController,
                onChanged: (value) {
                  emailController.onChanged(value);
                  emailController.validate(values: {'emails' : _registerController.emails});
                },
              ),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Input(
                  label: 'textPassword'.tr,
                  prefixIcon: const Icon(Icons.password),
                  controller: passwordController,
                  onChanged: (value) {
                    passwordController.onChanged(value);
                    passwordController.validate();
                  },
                  suffixIcon: IconButton(
                    onPressed:
                    passwordController.toggleVisibility,
                    icon: Icon(
                      passwordController.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  obscureText: !passwordController.isVisible,
                ),
              );
            }),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Input(
                  label: 'textPassword'.tr,
                  prefixIcon: const Icon(Icons.password),
                  controller: repeatPasswordController,
                  onChanged: (value) {
                    repeatPasswordController.onChanged(value);
                    repeatPasswordController.validate(values: {'password': passwordController.text});
                  },
                  suffixIcon: IconButton(
                    onPressed:
                    repeatPasswordController.toggleVisibility,
                    icon: Icon(
                      repeatPasswordController.isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  obscureText: !repeatPasswordController.isVisible,
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Input(
                label: 'textName'.tr,
                prefixIcon: const Icon(Icons.edit),
                controller: nameController,
                onChanged: (value) {
                  nameController.onChanged(value);
                  nameController.validate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Input(
                label: 'textSurname'.tr,
                prefixIcon: const Icon(Icons.edit),
                controller: surnameController,
                onChanged: (value) {
                  surnameController.onChanged(value);
                  surnameController.validate();
                },
              ),
            ),
            Card(
              shape: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurface, width: 3.0),
              ),
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'textSelectYourGender'.tr,
                        style: Get.isDarkMode
                            ? const TextStyle(color: Color(0xFF969ba4))
                            : const TextStyle(color: Color(0xFF5e5e5e)),
                      )),
                  GenderPickerWithImage(
                    unSelectedGenderTextStyle: Get.isDarkMode
                        ? const TextStyle(
                            color: Color(0xFF969ba4),
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          )
                        : const TextStyle(
                            color: Color(0xFF5e5e5e),
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                    selectedGender: Gender.Male,
                    onChanged: (Gender? gender) {
                      if (gender == Gender.Female) {
                        genderController.gender = 'female';
                      } else {
                        genderController.gender = 'male';
                      }
                    },
                    maleText: 'textMale'.tr,
                    femaleText: 'textFemale'.tr,
                  )
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: level),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: position),
            ExpandedButton(
              text: 'registerTitle'.tr,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              onPressed: () => _register(context),
            ),
          ],
        ),
      ),
    );
  }
}
