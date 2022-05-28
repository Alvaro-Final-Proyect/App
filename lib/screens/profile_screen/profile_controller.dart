import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';
import 'package:padel/core/retrofit_helper.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/save_user_use_case.dart';

class ProfileController extends GetxController {
  final _currentUser = RetrofitHelper.user.obs;
  UserModel? get currentUser => _currentUser.value;

  String error = '';

  final pickedImage = ''.obs;
  final saveUserUseCase = SaveUserUseCase();

  Future<void> save(String username, String email, String name, String surname,
      String position) async {
    currentUser?.username = username;
    currentUser?.email = email;
    currentUser?.name = name;
    currentUser?.surname = surname;
    currentUser?.position = position;
    if(pickedImage.isNotEmpty){
      currentUser?.image = pickedImage.value;
    }

    try{
      await saveUserUseCase(currentUser!);
      error = '';
    }catch(e){
      error = 'Could not save your profile';
    }
  }

  void setUserImage(String imageBase64){
    pickedImage.value = imageBase64;
  }
}
