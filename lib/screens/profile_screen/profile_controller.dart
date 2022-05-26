import 'dart:developer';
import 'dart:typed_data';
import 'package:padel/core/retrofit_helper.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/save_user_use_case.dart';

class ProfileController extends GetxController {
  final _currentUser = RetrofitHelper.user.obs;
  UserModel? get currentUser => _currentUser.value;

  String error = '';

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
      error = '';
    }catch(e){
      log('update error: $e');
      error = 'Could not save your profile';
    }
  }

  void setUserImage(String imageBase64){
    _currentUser.update((val) {
      val?.image = imageBase64;
    });
  }
}
