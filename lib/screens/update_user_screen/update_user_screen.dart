import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/update_user_screen/update_user_body.dart';
import 'package:padel/screens/update_user_screen/update_user_controller.dart';
import 'package:padel/widgets/loading_popup.dart';

class UpdateUserScreen extends StatelessWidget {
  UpdateUserScreen({Key? key}) : super(key: key);

  final _updateUserController = Get.put(UpdateUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textUpdateUser'.tr),
        actions: [
          IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus;
              _updateUserController.toggleSearch();
            },
            icon: Obx(() {
              return Icon(_updateUserController.isSearching
                  ? Icons.search_off
                  : Icons.search);
            }),
          ),
        ],
      ),
      body: Obx(
        () {
          return _updateUserController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : UpdateUserBody();
        },
      ),
      floatingActionButton: Obx(() {
        return _updateUserController.selectedUser == null
            ? Container()
            : FloatingActionButton(
                onPressed: () => _saveUser(context),
                child: const Icon(Icons.save),
              );
      }),
    );
  }

  void _saveUser(context) {
    final selectedUser = _updateUserController.selectedUser;

    final validations = [
      selectedUser != null,
      _updateUserController.usernameController.validate(values: {
        'usernames': _updateUserController
            .usernames
            .where((element) =>
        element !=
            _updateUserController
                .selectedUser!.username).toList()
      }),
      _updateUserController.emailController.validate(values: {
        'emails': _updateUserController
            .emails
            .where((element) =>
        element !=
            _updateUserController
                .selectedUser!.email).toList()
      }),
      _updateUserController.nameController.validate(),
      _updateUserController.surnameController.validate(),
      _updateUserController.levelController.validate(),
      _updateUserController.positionController.selected != null,
      _updateUserController.genderController.selected != null,
    ];

    if(!validations.contains(false) && selectedUser != null){
      selectedUser.username = _updateUserController.usernameController.text;
      selectedUser.email = _updateUserController.emailController.text;
      selectedUser.name = _updateUserController.nameController.text;
      selectedUser.surname = _updateUserController.surnameController.text;
      selectedUser.level = double.parse(_updateUserController.levelController.text);
      selectedUser.isAdmin = _updateUserController.isAdminController.isChecked.value;
      selectedUser.position = _updateUserController.positionController.selected!.name;
      selectedUser.gender = _updateUserController.genderController.selected!.name;
      selectedUser.password = null;

      LoadingPopup.show(context: context);
      _updateUserController.saveUser().then((value) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(
              value ? 'Usuario guardado correctamente' : 'Error al guardar',
            ),
          ),
        );
        if(value) {
          Get.back();
        }
      });
    }else{
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
