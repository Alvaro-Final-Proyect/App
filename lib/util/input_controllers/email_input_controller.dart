import 'package:get/get.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';

class EmailInputController extends TextInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(!text.isEmail){
      error = 'Format: example@example.es';
      return false;
    }

    final emails = values?['emails'] as List<String>;
    if(emails.contains(text)){
      error = 'Email already in use';
      return false;
    }

    error = null;
    return true;
  }
}