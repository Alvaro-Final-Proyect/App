import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/screens/create_user_screen/create_user_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import 'package:padel/widgets/expanded_button.dart';
import 'package:padel/widgets/input.dart';
import 'package:padel/widgets/loading_popup.dart';

enum Position { right, backhand, indifferent }
enum Gender { male, female }

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
            controller: _createUserController.usernameController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            onChanged: (value) {
              _createUserController.usernameController.onChanged(value);
              _createUserController.usernameController.validate(
                  values: {'usernames': _createUserController.usernames});
            },
            label: 'textUsername'.tr,
          ),
          // EMAIL
          Input(
            controller: _createUserController.emailController,
            prefixIcon: const Icon(Icons.email),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.emailController.onChanged(value);
              _createUserController.emailController
                  .validate(values: {'emails': _createUserController.emails});
            },
            label: 'textEmail'.tr,
          ),
          // PASSWORD
          Obx(() {
            return Input(
              controller: _createUserController.passwordController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              onChanged: (value) {
                _createUserController.passwordController.onChanged(value);
                _createUserController.passwordController.validate();
                _createUserController.repeatPasswordController.validate(
                  values: {
                    'password': _createUserController.passwordController.text,
                  },
                );
              },
              label: 'textPassword'.tr,
              suffixIcon: IconButton(
                onPressed:
                    _createUserController.passwordController.toggleVisibility,
                icon: Icon(
                  _createUserController.passwordController.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              obscureText: !_createUserController.passwordController.isVisible,
            );
          }),
          // REPEAT PASSWORD
          Obx(() {
            return Input(
              controller: _createUserController.repeatPasswordController,
              prefixIcon: const Icon(Icons.password),
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              onChanged: (value) {
                _createUserController.repeatPasswordController.onChanged(value);
                _createUserController.repeatPasswordController.validate(
                  values: {
                    'password': _createUserController.passwordController.text,
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
          // NAME
          Input(
            controller: _createUserController.nameController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.nameController.onChanged(value);
              _createUserController.nameController.validate();
            },
            label: 'textName'.tr,
          ),
          // SURNAME
          Input(
            controller: _createUserController.surnameController,
            prefixIcon: const Icon(Icons.person),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.surnameController.onChanged(value);
              _createUserController.surnameController.validate();
            },
            label: 'textSurname'.tr,
          ),
          // Level
          Input(
            controller: _createUserController.levelController,
            prefixIcon: const Icon(Icons.timeline),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            onChanged: (value) {
              _createUserController.levelController.onChanged(value);
              _createUserController.levelController.validate();
            },
            label: 'textLevel'.tr,
          ),
          // IS ADMIN
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: CustomCheckbox(
              checkboxController: _createUserController.checkboxController,
              title: 'textIsAdmin'.tr,
            ),
          ),
          // Position
          Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: DropdownButtonFormField<Position>(
              items: Position.values.map(
                (position) {
                  return DropdownMenuItem(
                    value: position,
                    child: Text(
                      'text${position.name.capitalize ?? ''}Position'.tr,
                    ),
                  );
                },
              ).toList(),
              onChanged: _createUserController.positionController.onChanged,
              hint: Text('textSelectYourPosition'.tr),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 3.0)),
                prefixIcon: const Icon(FontAwesomeIcons.tableTennisPaddleBall),
              ),
              value: _createUserController.positionController.selected,
            ),
          ),
          // Gender
          Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: DropdownButtonFormField<Gender>(
              items: Gender.values.map(
                (gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(
                      'text${gender.name.capitalize ?? ''}'.tr,
                    ),
                  );
                },
              ).toList(),
              onChanged: _createUserController.genderController.onChanged,
              hint: Text('textSelectYourGender'.tr),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 3.0)),
                  prefixIcon: Obx(() {
                    switch (_createUserController.genderController.selected) {
                      case Gender.male:
                        return const Icon(Icons.man);
                      case Gender.female:
                        return const Icon(Icons.woman);
                      default:
                        return const Icon(Icons.elderly_woman);
                    }
                  })),
              value: _createUserController.genderController.selected,
            ),
          ),
          // Button
          ExpandedButton(
            text: 'textCreateUser'.tr,
            onPressed: () => _createUser(context),
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }

  void _createUser(BuildContext context) {
    final validations = [
      _createUserController.usernameController
          .validate(values: {'usernames': _createUserController.usernames}),
      _createUserController.emailController
          .validate(values: {'emails': _createUserController.emails}),
      _createUserController.passwordController.validate(),
      _createUserController.repeatPasswordController.validate(
          values: {'password': _createUserController.passwordController.text}),
      _createUserController.nameController.validate(),
      _createUserController.surnameController.validate(),
      _createUserController.levelController.validate(),
      _createUserController.positionController.selected != null,
      _createUserController.genderController.selected != null
    ];

    if (!validations.contains(false)) {
      final username = _createUserController.usernameController.text;
      final email = _createUserController.emailController.text;
      final password = _createUserController.passwordController.text;
      final name = _createUserController.nameController.text;
      final surname = _createUserController.surnameController.text;
      final level = double.parse(_createUserController.levelController.text);
      final isAdmin = _createUserController.checkboxController.isChecked.value;
      final position = _createUserController.positionController.selected!.name;
      final gender = _createUserController.genderController.selected!.name;

      final user = UserModel(
          username: username,
          email: email,
          password: password,
          name: name,
          surname: surname,
          level: level,
          isAdmin: isAdmin,
          position: position,
          gender: gender);

      LoadingPopup.show(context: context);

      _createUserController.createUser(user).then((value) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value
                  ? 'Usuario creado correctamente'
                  : 'No se ha podido crear el usuario',
            ),
          ),
        );

        if (value) {
          Get.back();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error, Check the fields!',
          ),
        ),
      );
    }
  }
}
