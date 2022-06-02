import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';

class PasswordInputController extends TextInputController {
  final _isVisible = false.obs;
  set isVisible(value) => _isVisible.value = value;
  bool get isVisible => _isVisible.value;

  void toggleVisibility() => isVisible = !isVisible;

  @override
  bool validate({Map<String, dynamic>? values}) {
    if(text.length < 5){
      error = 'Min length is 5';
      return false;
    }

    if(!text.characters.any((element) => element.isAlphabetOnly)){
      error = 'Must contain a letter';
      return false;
    }

    if(!text.characters.any((element) => element.isNum)){
      error = 'Must contain a number';
      return false;
    }

    error = null;
    return true;
  }
}