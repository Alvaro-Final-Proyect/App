import 'dart:developer';

import 'package:get/get.dart';
import 'package:padel/domain/get_all_usernames_use_case.dart';
import 'package:padel/util/input_validations/password_input_controller.dart';
import 'package:padel/util/input_validations/username_input_controller.dart';
import '../../util/input_validations/email_input_validation.dart';
import '../../util/input_validations/repeat_password_input_controller.dart';

class CreateUserController extends GetxController {
  final usernameInputController = UsernameInputController();
  final emailInputController = EmailInputController();
  final passwordInputController = PasswordInputController();
  final repeatPasswordController = RepeatPasswordInputController();

  final getAllUsernamesUseCase = GetAllUsernamesUseCase();

  var usernames = <String>[];

  @override
  void onInit() {
    super.onInit();
    loadUsernames();
  }

  void loadUsernames() async {
    try{
      usernames = await getAllUsernamesUseCase();
      log('usernames: $usernames');
    }catch(e){
      log('error: $e');
    }
  }
}