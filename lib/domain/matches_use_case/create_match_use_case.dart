import 'package:padel/data/models/match_model.dart';
import '../../data/network/api_service.dart';

class CreateMatchUseCase {
  final ApiService _api = ApiService();
  Future<MatchModel> call(MatchModel match) => _api.createMatch(match);
}