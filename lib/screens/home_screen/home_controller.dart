import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/core/shared_preferences_helper.dart';
import 'package:padel/domain/user_use_case/get_user_from_token_use_case.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final _isLoading = false.obs;
  final _loadError = ''.obs;


  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;
  final _getUserFromTokenUseCase = GetUserFromTokenUseCase();

  Future<void> loadUser() async {
    _isLoading.value = true;
    RetrofitHelper.user = await _getUserFromTokenUseCase();
    _isLoading.value = false;
  }

  Future<void> logout() async {
    _isLoading.value = true;
    RetrofitHelper.setToken(null);
    SharedPreferencesHelper.sharedPreferences.setString('token', '');
    _isLoading.value = false;
  }
}