import 'package:padel/util/input_controllers/text_input_controller.dart';

class EmptyInputController extends TextInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(text.isEmpty){
      error = 'Input can\'t be empty';
      return false;
    }

    error = null;
    return true;
  }
}