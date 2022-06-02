import 'dart:developer';

import 'package:get/get.dart';
import 'package:padel/domain/get_all_usernames_use_case.dart';
import 'package:padel/util/input_validations/username_input_controller.dart';

class CreateUserController extends GetxController {
  final usernameInputController = UsernameInputController();

  final getAllUsernamesUseCase = GetAllUsernamesUseCase();

  var usernames = <String>[];

  void loadUsernames() async {
    try{
      usernames = await getAllUsernamesUseCase();
    }catch(e){
      log('error: $e');
    }
  }
}