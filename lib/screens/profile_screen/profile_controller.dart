import 'dart:developer';

import 'package:padel/core/retrofit_helper.dart';
import 'package:get/get.dart';
import 'package:padel/domain/user_use_case/save_user_use_case.dart';

class ProfileController extends GetxController {
  final currentUser = RetrofitHelper.user;

  final saveUserUseCase = SaveUserUseCase();

  Future<void> save(String username, String email, String name, String surname,
      String position) async {

    currentUser?.username = username;
    currentUser?.email = email;
    currentUser?.name = name;
    currentUser?.surname = surname;
    currentUser?.position = position;

    try{
      await saveUserUseCase(currentUser!);
    }catch(e){
      log('update error: $e');
    }
  }
}
