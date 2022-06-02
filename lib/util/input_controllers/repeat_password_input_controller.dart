import 'package:padel/util/input_controllers/password_input_controller.dart';

class RepeatPasswordInputController extends PasswordInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    final password = values?['password'] ?? '';
    if(password != text) {
      error = 'Both passwords must be equals';
      return false;
    }

    if(!super.validate()){
      return false;
    }

    error = null;
    return true;
  }
}