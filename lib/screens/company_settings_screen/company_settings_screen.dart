import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/company_settings_screen/company_settings_body.dart';
import 'package:padel/screens/company_settings_screen/company_settings_controller.dart';
import 'package:padel/widgets/confirm_dialog.dart';
import 'package:padel/widgets/loading_popup.dart';

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
          bool matchPriceValidation = _companySettingsController.matchPriceInputController.validate({});
          if(matchPriceValidation){
            ConfirmDialog.show(context, onContinue: () async {
              double matchPrice = double.parse(_companySettingsController.matchPriceInputController.text);
              _companySettingsController.companySettings.matchPrice = matchPrice;
              LoadingPopup.show(context: context);
              await _companySettingsController.updateCompanySettings().then((value) {
                Get.back();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'textCompanyUpdated'.tr
                    ),
                  ),
                );
              }).catchError((err) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Unexpected error'
                    ),
                  ),
                );
              });

              Get.back();
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'textCheckFields'.tr
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
