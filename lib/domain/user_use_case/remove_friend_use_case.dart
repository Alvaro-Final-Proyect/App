import '../../data/models/user_response.dart';
import '../../data/network/api_service.dart';

class RemoveFriendUseCase {
  final ApiService _api = ApiService();
  Future<UserModel> call(String acceptedId) => _api.removeFriend(acceptedId);
}