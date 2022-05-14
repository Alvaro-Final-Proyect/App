import 'package:padel/data/models/user_response.dart';
import '../data/network/api_service.dart';

class RegisterUseCase{
  final ApiService _api = ApiService();
  call(UserModel newUser) => _api.register(newUser);
}