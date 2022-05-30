import 'dart:developer';

import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/domain/user_use_case/get_user_from_token_use_case.dart';
import 'package:padel/domain/login_use_case.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final loginUseCase = LoginUseCase();
  final getUserFromTokenUseCase = GetUserFromTokenUseCase();

  Future<void> login(String username, String password, bool keepLogged) async {
    _isLoading.value = true;
    log('$username $password');

    try{
      final token = await loginUseCase(username, password);
      if(token.token == null || token.token == ''){
        _loadError.value = 'User or password invalid';
      }else {
        _loadError.value = '';
        RetrofitHelper.setToken(token.token!);
        final preferences = await SharedPreferences.getInstance();
        if(keepLogged){await preferences.setString('token', token.token!); }
        RetrofitHelper.user = await getUserFromTokenUseCase();
      }
    }on Exception catch(_){
      _loadError.value = 'User or password invalid';
    }
    _isLoading.value = false;
  }
}