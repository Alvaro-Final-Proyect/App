import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/domain/company_use_case/update_company_use_case.dart';

import '../../util/input_validations/number_input_controller.dart';

class CompanySettingsController extends GetxController {
  final companySettings = RetrofitHelper.companySettings;
  final matchPriceInputController = NumberInputController();

  final updateCompanyUseCase = UpdateCompanyUseCase();

  Future<void> updateCompanySettings() async {
    await updateCompanyUseCase(companySettings);
  }
}