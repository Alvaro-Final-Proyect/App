import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/administration_screen/administration_controller.dart';
import 'administration_body.dart';

enum Menu { createUser, updateUser, companyConfiguration, }


class AdministrationScreen extends StatelessWidget {
  AdministrationScreen({Key? key}) : super(key: key);

  final _administrationController = Get.put(AdministrationController());

  void _handleMenuSelection(item) {
    switch(item){
      case Menu.createUser:
        break;
      case Menu.updateUser:
        break;
      case Menu.companyConfiguration:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textAdministration'.tr),
        actions: [
          PopupMenuButton<Menu>(
            onSelected: _handleMenuSelection,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: Menu.createUser,
                  child: Text('Create User'),
                ),
                const PopupMenuItem(
                  value: Menu.updateUser,
                  child: Text('Update User'),
                ),
                const PopupMenuItem(
                  value: Menu.companyConfiguration,
                  child: Text('Configuración Empresa'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Obx(
        () {
          return _administrationController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : AdministrationBody();
        },
      ),
    );
  }
}
