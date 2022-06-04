import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/data/network/api_service.dart';

class GetAllTournamentsUseCase {
  final _api = ApiService();
  Future<List<TournamentModel>> call() => _api.getAllTournaments();
}