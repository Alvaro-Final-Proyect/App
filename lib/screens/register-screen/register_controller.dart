import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/register_use_case.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final registerUseCase = RegisterUseCase();

  Future<void> register(
    String username,
    String email,
    String name,
    String password,
    String surname,
    String level,
    String position,
    String gender,
  ) async {
    _isLoading.value = true;

    UserModel newUser = UserModel(
      username: username,
      email: email,
      name: name,
      surname: surname,
      password: password,
      level: double.parse(level),
      gender: gender,
      position: position
    );

    try{
      await registerUseCase(newUser);
    }on Exception catch(_){
      _loadError.value = 'An error occurred on register';
    }

    _isLoading.value = false;
  }
}