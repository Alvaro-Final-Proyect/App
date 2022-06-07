import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/register_use_case.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final registerUseCase = RegisterUseCase();

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