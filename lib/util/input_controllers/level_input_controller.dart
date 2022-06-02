import 'package:padel/util/input_controllers/number_input_controller.dart';

class LevelInputController extends NumberInputController {
  @override
  bool validate({Map<String, dynamic>? values}) {
    if(!super.validate(values: values)){
      return false;
    }

    final level = double.parse(text);

    if(level.clamp(0, double.infinity) != level){
      error = 'Min level is 0';
      return false;
    }

    error = null;
    return true;
  }
}
