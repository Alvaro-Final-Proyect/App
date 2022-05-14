import 'package:padel/data/models/user_response.dart';
import '../../data/network/api_service.dart';

class SaveUserUseCase {
  final ApiService _api = ApiService();
  Future<void> call(UserModel userModel) => _api.saveUser(userModel);
}