import '../../data/network/api_service.dart';

class SendMatchInvitationUseCase {
  final ApiService _api = ApiService();

  Future<void> call(String matchId, String userInvitedId) =>
      _api.sendMatchInvitation(matchId, userInvitedId);
}
