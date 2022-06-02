import '../data/network/api_service.dart';

class LoginUseCase {
  final ApiService _api = ApiService();
  Future<List<String>> call() => _api.getAllUsernames();
}