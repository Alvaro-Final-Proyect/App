import '../../data/models/user_response.dart';
import '../../data/network/api_service.dart';

class CreateUserUseCase {
  final ApiService _api = ApiService();
  Future<UserModel> call(UserModel userModel) => _api.createUser(userModel);
}