import 'dart:developer';

import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/register_use_case.dart';
import 'package:get/get.dart';
import 'package:padel/util/input_controllers/email_input_controller.dart';
import 'package:padel/util/input_controllers/empty_input_controller.dart';
import 'package:padel/util/input_controllers/password_input_controller.dart';
import 'package:padel/util/input_controllers/repeat_password_input_controller.dart';
import 'package:padel/util/input_controllers/username_input_controller.dart';

import '../../domain/get_all_usernames_use_case.dart';

class RegisterController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final usernameController = UsernameInputController();
  final emailController = EmailInputController();
  final passwordController = PasswordInputController();
  final repeatPasswordController = RepeatPasswordInputController();
  final nameController = EmptyInputController();
  final surnameController = EmptyInputController();

  final registerUseCase = RegisterUseCase();
  final getAllUsernamesAndEmailsUseCase = GetAllUsernamesAndEmailsUseCase();

  var usernames = <String>[];
  var emails = <String>[];

  @override
  void onInit() {
    super.onInit();
    loadUsernamesAndEmails();
  }

  void loadUsernamesAndEmails() async {
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

  Future<void> register({
      required String username,
      required String email,
      required String password,
      required String name,
      required String surname,
      required String level,
      required String position,
      required String gender,
  }) async {
    _isLoading.value = true;

    UserModel newUser = UserModel(
      username: username,
      email: email,
      name: name,
      surname: surname,
      password: password,
      level: double.parse(level),
      gender: gender,
      position: position,
      matchesInvitations: []
    );

    try{
      await registerUseCase(newUser);
    }on Exception catch(_){
      _loadError.value = 'Could not create your account';
    }

    _isLoading.value = false;
  }
}