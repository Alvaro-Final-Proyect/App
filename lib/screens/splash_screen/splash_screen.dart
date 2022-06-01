import 'dart:developer';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:padel/domain/user_use_case/get_user_from_token_use_case.dart';
import 'package:padel/screens/home_screen/home_page.dart';
import 'package:padel/screens/login_screen/login_page.dart';
import '../../core/retrofit_helper.dart';
import '../../core/shared_preferences_helper.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final _splashController = SplashController();

  Future<Widget> loadFirstScreen() async {
    String? token = SharedPreferencesHelper.sharedPreferences.getString('token');

    if((token?.isNotEmpty ?? false) && await _splashController.checkToken(token!)){
      return HomePage();
    }

    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/raqueta-de-padel.png'),
      futureNavigator: loadFirstScreen(),
      backgroundColor: Get.theme.colorScheme.onSurface,
      showLoader: false,
      title: const Text('Padel IT'),
    );
  }
}

class SplashController extends GetxController {
  final getUserFromTokenUseCase = GetUserFromTokenUseCase();

  Future<bool> checkToken(String token) async {
    RetrofitHelper.setToken(token);
    try{
      final user = await getUserFromTokenUseCase();
      RetrofitHelper.user = user;
      return true;
    }catch(e){
      log('error: $e');
      return false;
    }
  }
}
