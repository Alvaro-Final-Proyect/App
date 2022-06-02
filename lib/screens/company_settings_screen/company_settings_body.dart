import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/company_settings_screen/company_settings_controller.dart';
import 'package:padel/util/input_validations/number_input_controller.dart';

class CompanySettingsBody extends StatelessWidget {
  CompanySettingsBody({Key? key}) : super(key: key);

  final _companySettingsController = Get.find<CompanySettingsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Obx(
                  () {
                return TextFormField(
                  initialValue: _companySettingsController.companySettings.matchPrice.toString(),
                  onChanged: (value) {
                    _companySettingsController.matchPriceInputController.onChanged(value);
                    _companySettingsController.matchPriceInputController.validate({});
                  },
                  decoration: InputDecoration(
                    labelText: 'textMatchPrice'.tr,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    prefixIcon: const Icon(Icons.price_change),
                    errorText: _companySettingsController.matchPriceInputController.error,
                    suffixIcon: const Icon(Icons.euro)
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
