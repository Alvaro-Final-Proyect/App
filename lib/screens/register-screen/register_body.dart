import 'package:padel/screens/register-screen/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/expanded_button.dart';

class GenderController {
  String gender = 'male';
}

class RegisterBody extends StatelessWidget {
  RegisterBody({Key? key}) : super(key: key);

  void _register() async {
    bool usernameValidation = username.validator(
        username.customTextFieldController, username.textEditingController);
    bool emailValidation = email.validator(
        email.customTextFieldController, email.textEditingController);
    bool passwordValidation = password.validator(
        password.customPasswordFieldController, password.textEditingController);
    bool repeatPasswordValidation = repeatPassword.validator(
        repeatPassword.customPasswordFieldController,
        repeatPassword.textEditingController);
    bool nameValidation = name.validator(
        name.customTextFieldController, name.textEditingController);
    bool surnameValidation = surname.validator(
        surname.customTextFieldController, surname.textEditingController);
    bool levelValidation = level.validator(level.dropDownMenuController);
    bool positionValidation =
        position.validator(position.dropDownMenuController);

    printInfo(info: position.dropDownMenuController.selected.value);

    if (usernameValidation &&
        emailValidation &&
        passwordValidation &&
        repeatPasswordValidation &&
        nameValidation &&
        surnameValidation &&
        levelValidation &&
        positionValidation
    ) {
      await _registerController.register(
          username: username.textEditingController.text,
          email: email.textEditingController.text,
          password: password.textEditingController.text,
          name: name.textEditingController.text,
          surname: surname.textEditingController.text,
          level: level.dropDownMenuController.selected.value,
          position: position.dropDownMenuController.selectedValue,
          gender: genderController.gender);

      if (_registerController.loadError() == '') {
        Fluttertoast.showToast(
            msg: 'User registered correctly',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            backgroundColor: Colors.white38);
        Get.back();
      }
      else {
        printInfo(info: _registerController.loadError());
      }
    }
  }

  final RegisterController _registerController = Get.find();
  final GenderController genderController = GenderController();
  final username = CustomTextField(
    validator: (customTextFieldController, textEditingController) {
      final String text = textEditingController.text;
      bool result = false;

      if (text.isBlank ?? true) {
        customTextFieldController.textError.value = 'Username cant be blank';
      } else {
        customTextFieldController.textError.value = '';
        result = true;
      }
      return result;
    },
    labelText: 'textUsername',
    icon: Icons.person,
    margin: const EdgeInsets.all(10),
  );
  final email = CustomTextField(
      labelText: 'textEmail',
      icon: Icons.email,
      margin: const EdgeInsets.all(10),
      validator: (customTextFieldController, textEditingController) {
        final String text = textEditingController.text;
        bool result = false;

        if (text.isBlank ?? true) {
          customTextFieldController.textError.value = 'Email cant be blank';
        } else if (!text.isEmail) {
          customTextFieldController.textError.value =
              'Email format error: example@example.es';
        } else {
          customTextFieldController.textError.value = '';
          result = true;
        }

        return result;
      });
  final password = CustomPasswordField(
      labelText: 'textPassword',
      margin: const EdgeInsets.all(10),
      validator: (customPasswordFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customPasswordFieldController.textError;
        bool result = false;

        if (text.isBlank ?? true) {
          textError.value = 'Password cant be empty';
        } else if (text.length < 5) {
          textError.value = 'Password length must be 5 or more';
        } else {
          textError.value = '';
          result = true;
        }
        return result;
      });
  final repeatPassword = CustomPasswordField(
      labelText: 'textRepeatPassword',
      margin: const EdgeInsets.all(10),
      validator: (customPasswordFieldController, textEditingController) {
        final String text = textEditingController.text;
        final RxString textError = customPasswordFieldController.textError;
        bool result = false;

        if (text.isBlank ?? true) {
          textError.value = 'Password cant be empty';
        } else if (text.length < 5) {
          textError.value = 'Password length must be 5 or more';
        } else {
          textError.value = '';
          result = true;
        }
        return result;
      });
  final name = CustomTextField(
      labelText: 'textName',
      icon: null,
      margin: const EdgeInsets.all(10),
      validator: (customTextFieldController, textEditingController) {
        final String text = textEditingController.text;
        bool result = false;

        if (text.isBlank ?? true) {
          customTextFieldController.textError.value = 'Username cant be blank';
        } else {
          customTextFieldController.textError.value = '';
          result = true;
        }

        return result;
      });
  final surname = CustomTextField(
      labelText: 'textSurname',
      icon: null,
      margin: const EdgeInsets.all(10),
      validator: (customTextFieldController, textEditingController) {
        final String text = textEditingController.text;
        bool result = false;

        if (text.isBlank ?? true) {
          customTextFieldController.textError.value = 'Username cant be blank';
        } else {
          customTextFieldController.textError.value = '';
          result = true;
        }

        return result;
      });
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
    return Center(
      child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              username,
              email,
              password,
              repeatPassword,
              name,
              surname,
              Card(
                color: const Color.fromRGBO(250, 250, 250, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(
                    color: Color.fromRGBO(150, 150, 150, 1), width: 1.0
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'textSelectYourGender'.tr,
                        style: const TextStyle(
                          color: Color.fromRGBO(90, 90, 90, 1)
                        ),
                      )
                    ),
                    GenderPickerWithImage(
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
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
              Padding(
                padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: level),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 0
                ),
                child: position),
              ExpandedButton(
                text: 'registerTitle'.tr,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                onPressed: _register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}