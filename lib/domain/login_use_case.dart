import 'package:padel/data/models/token_response.dart';
import 'package:padel/data/network/api_service.dart';

class LoginUseCase {
  final ApiService _api = ApiService();
  Future<TokenModel> call(String username, String password) => _api.login(username, password);
}