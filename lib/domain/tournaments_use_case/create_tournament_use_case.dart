import 'package:padel/data/network/api_service.dart';
import '../../data/models/tournament_model.dart';

class CreateTournamentUseCase {
  final _api = ApiService();
  Future<TournamentModel> call(Map<String, dynamic> body) => _api.createTournament(body);
}