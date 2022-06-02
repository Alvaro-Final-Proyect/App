import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/administration_screen/administration_controller.dart';
import 'administration_body.dart';

enum Menu { createUser, updateUser, companyConfiguration, }


class AdministrationScreen extends StatelessWidget {
  AdministrationScreen({Key? key}) : super(key: key);

  final _administrationController = Get.put(AdministrationController());

  void _handleMenuSelection(item) {
    switch (item) {
      case Menu.createUser:
        break;
      case Menu.updateUser:
        break;
      case Menu.companyConfiguration:
        Get.toNamed('/home/administration/companySettings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textAdministration'.tr),
        actions: [
          IconButton(
            onPressed: _administrationController.loadLastWeekMatches,
            icon: const Icon(Icons.refresh,),
            tooltip: 'textRefreshStatistics'.tr,
          ),
          PopupMenuButton<Menu>(
            onSelected: _handleMenuSelection,
            tooltip: 'textOptions'.tr,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: Menu.createUser,
                  child: Text('textCreateUser'.tr),
                ),
                PopupMenuItem(
                  value: Menu.updateUser,
                  child: Text('textUpdateUser'.tr),
                ),
                PopupMenuItem(
                  value: Menu.companyConfiguration,
                  child: Text('textCompanySettings'.tr),
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
