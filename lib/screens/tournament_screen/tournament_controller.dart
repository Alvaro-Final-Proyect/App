import 'dart:developer';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/domain/matches_use_case/join_to_match_use_case.dart';
import 'package:padel/domain/matches_use_case/leave_match_use_case.dart';
import 'package:padel/domain/matches_use_case/set_match_result_use_case.dart';
import 'package:padel/screens/tournament_screen/tournament_body.dart';
import '../../core/retrofit_helper.dart';
import '../../data/models/user_response.dart';
import '../../domain/matches_use_case/join_to_match_with_id_use_case.dart';

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
  }

  final UserModel currentUser = RetrofitHelper.user!;

  late Rx<TournamentModel> _tournament;

  TournamentModel get tournament => _tournament.value;

  set tournament(value) => _tournament.value = value;

  late List<MatchModel> tournamentMatches;
  late List<String?> tournamentPlayers;

  final joinToMatchUseCase = JoinToMatchUseCase();
  final joinToMatchWithIdUseCase = JoinToMatchWithIdUseCase();
  final leaveMatchUseCase = LeaveMatchUseCase();
  final setMatchResultUseCase = SetMatchResultUseCase();

  Future<bool> joinToMatch(MatchModel match, int index) async {
    bool error = false;

    try {
      final matchUpdated = await joinToMatchUseCase(match.id, index);
      match.players = matchUpdated.players;
      log('players: $tournamentPlayers');
      tournamentPlayers.add(currentUser.id);
      log('players: $tournamentPlayers');
      _tournament.refresh();
    } catch (e) {
      log('error: $e');
      error = true;
    }

    return error;
  }

  Future<bool> leaveMatch(MatchModel match,) async {
    bool error = false;

    try {
      final matchUpdated = await leaveMatchUseCase(match.id,);
      match.players = matchUpdated.players;
      tournamentPlayers.remove(currentUser.id);
      _tournament.refresh();
    } catch (e) {
      log('error: $e');
      error = true;
    }

    return error;
  }

  Future<bool> setMatchResult(MatchModel match, int winner, List<List<int>> result, Rounds round) async {
    bool error = false;

    try{
      await setMatchResultUseCase(match.id, winner, {'result': result});
      match.winner = winner;
      match.result = result;
      log('Winner: $winner');
      var winners = match.players.getRange(winner == 0 ? 0 : 2, winner == 0 ? 2 : 4).toList();

      if(round != Rounds.finalRound){
        joinWinnersToNextRound(winners, round, match.id);
      }
      _tournament.refresh();
    }catch(e){
      log('error: $e');
      error = true;
    }

    return error;
  }

  Future<bool> joinWinnersToNextRound(List<UserModel?> winners, Rounds round, String matchId) async {
    bool error = false;

    try{
      late int index;

      if(round == Rounds.roundOfSixteen){
        index = tournament.roundOfSixteen.indexWhere((element) => element.id == matchId);
      }else if(round == Rounds.quarterFinals) {
        index = tournament.quarterFinals.indexWhere((element) => element.id == matchId);
      }else {
        index = tournament.semifinals.indexWhere((element) => element.id == matchId);
      }

      final matchToJoinIndex = (index / 2).floor();
      late MatchModel matchToJoin;
      if(round == Rounds.roundOfSixteen){
        matchToJoin = tournament.quarterFinals[matchToJoinIndex];
      }else if(round == Rounds.quarterFinals) {
        matchToJoin = tournament.semifinals[matchToJoinIndex];
      }else {
        matchToJoin = tournament.finalMatch;
      }


      final startIndex = index % 2 == 0 ? 0 : 2;

      log('Users: ${winners.map((e) => e!.username!)}');
      log('Indexes: $startIndex - ${startIndex + 1}');
      log('ToJoin: ${matchToJoin.id}');

      await joinToMatchWithIdUseCase(matchToJoin.id, startIndex, winners[0]!.id!);
      final matchUpdated = await joinToMatchWithIdUseCase(matchToJoin.id, startIndex + 1, winners[1]!.id!);
      matchToJoin.players = matchUpdated.players;
      /* OCTAVOS
      * 0 / 2 --> CUARTOS 0
      * 1 / 2 --> .5 -> floor --> CUARTOS 0
      * 2 / 2 --> CUARTOS 1
      * 3 / 2 --> 1.5 -> floor -> CUARTOS 1
      * 4 / 2 --> CUARTOS 2
      * 5 / 2 --> 2.5 -> floor -> CUARTOS 2
      * 6 / 2 --> CUARTOS 3
      * 7 / 2 --> 3.5 -> floor -> CUARTOS 3
      * */
      /* CUARTOS
      * 0 / 2 --> SEMI 0
      * 1 / 2 --> .5 -> floor --> SEMI 0
      * 2 / 2 --> SEMI 1
      * 3 / 2 --> 1.5 -> floor -> SEMI 1
      * */
      _tournament.refresh();
    }catch(e){
      log('error: $e');
      error = true;
    }

    return error;
  }
}
