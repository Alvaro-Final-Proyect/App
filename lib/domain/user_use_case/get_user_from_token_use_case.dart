import 'package:padel/data/models/user_response.dart';
import 'package:padel/data/network/api_service.dart';

class GetUserFromTokenUseCase {
  final ApiService _api = ApiService();
  Future<UserModel> call() => _api.getUserFromToken();
}