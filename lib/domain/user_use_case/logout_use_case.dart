import '../../data/network/api_service.dart';

class LogoutUseCase {
  final ApiService _api = ApiService();
  Future<void> call() => _api.logout();
}