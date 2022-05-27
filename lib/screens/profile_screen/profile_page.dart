import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/profile_screen/profile_body.dart';
import 'package:padel/screens/profile_screen/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final profileController = Get.put(ProfileController());

  void _save(String username, String email, String name, String surname,
      String position, BuildContext context) {
    profileController
        .save(username, email, name, surname, position)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(profileController.error.isEmpty
              ? 'Tu perfil se ha guardado correctamente'
              : 'No hemos podido guardar tu perfil'),
        ),
      );
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ha ocurrido un error inesperado'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = ProfileBody();

    return Scaffold(
      appBar: AppBar(
        title: Text('titleProfile'.tr),
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool usernameValidation = body.username.validator(
              body.username.customTextFieldController,
              body.username.textEditingController);
          bool emailValidation = body.email.validator(
              body.email.customTextFieldController,
              body.email.textEditingController);
          bool nameValidation = body.name.validator(
              body.name.customTextFieldController,
              body.name.textEditingController);
          bool surnameValidation = body.surname.validator(
              body.surname.customTextFieldController,
              body.surname.textEditingController);
          bool positionValidation =
              body.position.validator(body.position.dropDownMenuController);

          if (usernameValidation &&
              emailValidation &&
              nameValidation &&
              surnameValidation &&
              positionValidation) {
            _save(
              body.username.textEditingController.text,
              body.email.textEditingController.text,
              body.name.textEditingController.text,
              body.surname.textEditingController.text,
              body.position.dropDownMenuController.selectedValue,
              context,
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
