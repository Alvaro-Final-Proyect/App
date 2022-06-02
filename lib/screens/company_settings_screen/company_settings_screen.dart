import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/company_settings_screen/company_settings_body.dart';
import 'package:padel/screens/company_settings_screen/company_settings_controller.dart';

class CompanySettingsScreen extends StatelessWidget {
  CompanySettingsScreen({Key? key}) : super(key: key);

  final _companySettingsController = Get.put(CompanySettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textCompanySettings'.tr),
      ),
      body: CompanySettingsBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO SHOW ARE U SURE?
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
