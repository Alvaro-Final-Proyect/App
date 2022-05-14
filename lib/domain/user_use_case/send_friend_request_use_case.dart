import '../../data/network/api_service.dart';

class SendFriendRequestUseCase {
  final ApiService _api = ApiService();
  Future<void> call(String requestedId) => _api.sendFriendRequest(requestedId);
}