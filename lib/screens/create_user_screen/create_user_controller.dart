import 'dart:developer';

import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/get_all_usernames_use_case.dart';
import 'package:padel/domain/user_use_case/create_user_use_case.dart';
import 'package:padel/util/input_controllers/empty_input_controller.dart';
import 'package:padel/util/input_controllers/level_input_controller.dart';
import 'package:padel/util/input_controllers/number_input_controller.dart';
import 'package:padel/util/input_controllers/password_input_controller.dart';
import 'package:padel/util/input_controllers/username_input_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import '../../util/input_controllers/drop_down_menu_controller.dart';
import '../../util/input_controllers/email_input_controller.dart';
import '../../util/input_controllers/repeat_password_input_controller.dart';
import 'create_user_body.dart';

class CreateUserController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final usernameController = UsernameInputController();
  final emailController = EmailInputController();
  final passwordController = PasswordInputController();
  final repeatPasswordController = RepeatPasswordInputController();
  final nameController = EmptyInputController();
  final surnameController = EmptyInputController();
  final levelController = LevelInputController();
  final checkboxController = CheckboxController();
  final positionController = DropdownMenuController<Position>(initial: Position.indifferent);
  final genderController = DropdownMenuController<Gender>(initial: Gender.male);

  final getAllUsernamesAndEmailsUseCase = GetAllUsernamesAndEmailsUseCase();
  final createUserUseCase = CreateUserUseCase();

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

  Future<bool> createUser(UserModel userModel) async {
    try{
      final newUser = await createUserUseCase(userModel);
      return true;
    }catch(e){
      return false;
    }
  }
}
