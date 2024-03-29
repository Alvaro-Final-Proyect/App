import 'package:padel/util/input_controllers/text_input_controller.dart';

class NumberInputController extends TextInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(double.tryParse(text) == null){
      error = 'Invalid number';
      return false;
    }

    error = null;
    return true;
  }
}
