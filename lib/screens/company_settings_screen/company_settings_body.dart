import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:padel/screens/company_settings_screen/company_settings_controller.dart';

class CompanySettingsBody extends StatelessWidget {
  CompanySettingsBody({Key? key}) : super(key: key);

  final _companySettingsController = Get.find<CompanySettingsController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [],
      ),
    );
  }
}
