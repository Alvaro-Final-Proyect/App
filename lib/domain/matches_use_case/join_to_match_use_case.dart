import 'package:padel/data/models/match_model.dart';
import '../../data/network/api_service.dart';

class JoinToMatchUseCase {
  final ApiService _api = ApiService();
  Future<MatchModel> call(String matchId, int index) => _api.joinToMatch(matchId, index);
}