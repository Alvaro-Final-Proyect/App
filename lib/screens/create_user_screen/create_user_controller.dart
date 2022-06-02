import 'dart:developer';
import 'package:get/get.dart';
import 'package:padel/domain/get_all_usernames_use_case.dart';
import 'package:padel/util/input_controllers/empty_input_controller.dart';
import 'package:padel/util/input_controllers/password_input_controller.dart';
import 'package:padel/util/input_controllers/username_input_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import '../../util/input_controllers/email_input_controller.dart';
import '../../util/input_controllers/repeat_password_input_controller.dart';

class CreateUserController extends GetxController {
  final usernameInputController = UsernameInputController();
  final emailInputController = EmailInputController();
  final passwordInputController = PasswordInputController();
  final repeatPasswordInputController = RepeatPasswordInputController();
  final nameInputController = EmptyInputController();
  final surnamePasswordController = EmptyInputController();
  final checkboxController = CheckboxController();

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