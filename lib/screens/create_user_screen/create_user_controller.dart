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

  final getAllUsernamesAndEmailsUseCase = GetAllUsernamesAndEmailsUseCase();

  var usernames = <String>[];
  var emails = <String>[];

  @override
  void onInit() {
    super.onInit();
    loadUsernames();
  }

  void loadUsernames() async {
    try {
      final data = (await getAllUsernamesAndEmailsUseCase()).data;
      final usernamesAndEmails = data;
      usernames = (usernamesAndEmails['usernames'] as List)
          .map((e) => e.toString())
          .toList();
      emails = (usernamesAndEmails['emails'] as List)
          .map((e) => e.toString())
          .toList();
    } catch (e) {
      log('error: $e');
    }
  }
}
