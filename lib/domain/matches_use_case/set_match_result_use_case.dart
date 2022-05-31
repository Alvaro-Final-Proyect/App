import 'package:padel/data/models/match_model.dart';

import '../../data/network/api_service.dart';

class SetMatchResultUseCase {
  final ApiService _api = ApiService();
  Future<void> call(String matchId, int winner, Map<String, List<List<int>>> result) => _api.setMatchResult(matchId, winner, result);
}