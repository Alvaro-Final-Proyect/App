import 'package:padel/data/models/user_response.dart';
import '../../data/network/api_service.dart';

class GetAllUsersUseCase {
  final ApiService _api = ApiService();
  Future<List<UserModel>> call() => _api.getAllUsers();
}