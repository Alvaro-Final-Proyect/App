import 'dart:developer';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/domain/matches_use_case/join_to_match_use_case.dart';
import '../../core/retrofit_helper.dart';
import '../../data/models/user_response.dart';

class TournamentController extends GetxController {
  TournamentController(TournamentModel tournamentModel) {
    _tournament = tournamentModel.obs;
    tournamentMatches = [
      ...tournamentModel.roundOfSixteen,
      ...tournamentModel.quarterFinals,
      ...tournamentModel.semifinals,
      tournamentModel.finalMatch,
    ];
    tournamentPlayers = tournamentMatches.map((match) => match.players.map((player) => player?.id))
        .expand((element) => element).toSet().toList()
        .where((element) => element != null).toList();
    log('Players: $tournamentPlayers,\nMatches: $tournamentMatches');
  }

  final UserModel currentUser = RetrofitHelper.user!;

  late Rx<TournamentModel> _tournament;

  TournamentModel get tournament => _tournament.value;

  set tournament(value) => _tournament.value = value;

  late List<MatchModel> tournamentMatches;
  late List<String?> tournamentPlayers;

  final joinToMatchUseCase = JoinToMatchUseCase();

  Future<bool> joinToMatch(MatchModel match, int index) async {
    bool error = false;

    try {
      final matchUpdated = await joinToMatchUseCase(match.id, index);
      match.players = matchUpdated.players;
      tournamentPlayers.add(match.id);
      _tournament.refresh();
    } catch (e) {
      log('error: $e');
      error = true;
    }

    return error;
  }
}
