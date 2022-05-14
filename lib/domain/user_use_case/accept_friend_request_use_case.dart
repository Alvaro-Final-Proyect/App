import '../../data/models/user_response.dart';
import '../../data/network/api_service.dart';

class AcceptFriendRequestUseCase {
  final ApiService _api = ApiService();
  Future<UserModel> call(String acceptedId) => _api.acceptFriendRequest(acceptedId);
}