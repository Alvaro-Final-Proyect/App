import 'package:padel/data/models/match_model.dart';
import '../../data/network/api_service.dart';

class GetInvitedMatchesUseCase {
  final ApiService _api = ApiService();

  Future<List<MatchModel>> call() =>
      _api.getInvitedMatches();
}
