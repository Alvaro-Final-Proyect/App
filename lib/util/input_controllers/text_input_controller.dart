import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TextInputController extends GetxController {
  String text = '';

  final _error = Rx<String?>(null);
  set error(String? value) => _error.value = value;
  String? get error => _error.value;

  void onChanged(String value) => text = value;
  bool validate({Map<String, dynamic>? values}) => true;
}