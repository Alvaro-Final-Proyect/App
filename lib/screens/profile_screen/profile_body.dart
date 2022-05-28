import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/profile_screen/profile_controller.dart';

import '../../res/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({Key? key}) : super(key: key);

  final profileController = Get.find<ProfileController>();

  final username = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textUsername',
      icon: Icons.person,
      validator: (customTextFieldController, textEditingController) {
        return true;
      });
  final email = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textEmail',
      icon: Icons.email,
      validator: (customTextFieldController, textEditingController) {
        return true;
      });
  final name = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textName',
      icon: Icons.badge,
      validator: (customTextFieldController, textEditingController) {
        return true;
      });
  final surname = CustomTextField(
      margin: const EdgeInsets.all(10),
      labelText: 'textSurname',
      icon: Icons.badge,
      validator: (customTextFieldController, textEditingController) {
        return true;
      });
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
    username.textEditingController.text =
        profileController.currentUser?.username ?? '';
    email.textEditingController.text =
        profileController.currentUser?.email ?? '';
    surname.textEditingController.text =
        profileController.currentUser?.surname ?? '';
    name.textEditingController.text = profileController.currentUser?.name ?? '';
    position.dropDownMenuController.selected.value =
        'text${profileController.currentUser?.position?.capitalize}Position';
    position.dropDownMenuController.selectedValue =
        profileController.currentUser!.position!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            heightFactor: 1.2,
            child: SizedBox(
              width: 100,
              height: 100,
              child: InkWell(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                      withData: true,
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg']);

                  if (result != null) {
                    final bytes = File(result.files.first.path!)
                        .readAsBytesSync()
                        .toList();
                    profileController.setUserImage(base64UrlEncode(bytes));
                  }
                },
                child: Obx(() {
                  return CircleAvatar(
                    backgroundImage: profileController.currentUser?.image == null
                      ? Image.network(userImageUrl).image
                      : Image.memory(
                          profileController.pickedImage.isEmpty ? base64Decode(
                            profileController.currentUser!.image!,
                          ) : base64Decode(
                            profileController.pickedImage.value,
                          )
                        ).image,
                  );
                }),
              ),
            ),
          ),
          username,
          email,
          name,
          surname,
          Padding(
            padding: const EdgeInsets.all(10),
            child: position,
          ),
        ],
      ),
    );
  }
}
