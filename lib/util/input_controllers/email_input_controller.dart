import 'package:get/get.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';

class EmailInputController extends TextInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(!text.isEmail){
      error = 'Format: example@example.es';
      return false;
    }

    error = null;
    return true;
  }
}