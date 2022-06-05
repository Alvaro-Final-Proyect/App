import 'package:padel/data/models/match_model.dart';
import '../../data/network/api_service.dart';

class JoinToMatchWithIdUseCase {
  final ApiService _api = ApiService();
  Future<MatchModel> call(String matchId, int index, String userId) => _api.joinToMatchWithId(matchId, index, userId);
}