import 'package:padel/data/models/match_model.dart';
import '../../data/network/api_service.dart';

class LeaveMatchUseCase {
  final ApiService _api = ApiService();
  Future<MatchModel> call(String matchId) => _api.leaveMatch(matchId);
}