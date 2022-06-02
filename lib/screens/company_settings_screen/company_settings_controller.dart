import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';

import '../../util/input_validations/number_input_controller.dart';

class CompanySettingsController extends GetxController {
  final companySettings = RetrofitHelper.companySettings;
  final matchPriceInputController = NumberInputController();
}