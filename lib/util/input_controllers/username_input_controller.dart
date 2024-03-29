import 'package:padel/util/input_controllers/text_input_controller.dart';

class UsernameInputController extends TextInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(text.isEmpty){
      error = 'Can\'t be empty';
      return false;
    }

    final usernames = values?['usernames'] as List<String>;
    if(usernames.contains(text)){
      error = 'Username already in use';
      return false;
    }

    error = null;
    return true;
  }
}