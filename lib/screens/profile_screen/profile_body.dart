import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:padel/screens/profile_screen/profile_controller.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class ProfileBody extends StatelessWidget{
  ProfileBody({Key? key}) : super(key: key);

  final username = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textUsername',
      icon: Icons.person,
      validator: (customTextFieldController, textEditingController) {
        return true;
      }
  );
  final email = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textEmail',
      icon: Icons.email,
      validator: (customTextFieldController, textEditingController) {
        return true;
      }
  );
  final name = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textName',
      icon: Icons.badge,
      validator: (customTextFieldController, textEditingController) {
        return true;
      }
  );
  final surname = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textSurname',
      icon: Icons.badge,
      validator: (customTextFieldController, textEditingController) {
        return true;
      }
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

      if(selected.isEmpty){
        textError.value = 'You have to select a position';
      }
      else{
        textError.value = '';
        result = true;
      }

      return result;
    },
  );
  final profileController = Get.put(ProfileController());

  String camelToSentence(String text) {
    var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
    var finalResult = result[0].toUpperCase() + result.substring(1);
    return finalResult;
  }
  
  @override
  Widget build(BuildContext context) {
    username.textEditingController.text = profileController.currentUser?.username ?? '';
    email.textEditingController.text = profileController.currentUser?.email ?? '';
    surname.textEditingController.text = profileController.currentUser?.surname ?? '';
    name.textEditingController.text = profileController.currentUser?.name ?? '';
    position.dropDownMenuController.selected.value = 'text${profileController.currentUser?.position?.capitalize}Position';

    return SingleChildScrollView(
      child: Column(
        children: [
          const Center(
            heightFactor: 1.2,
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png',
                ),
              ),
            ),
          ),
          username,
          email,
          name,
          surname,
          Padding(padding: const EdgeInsets.all(10), child: position,),
        ],
      ),
    );
  }
}