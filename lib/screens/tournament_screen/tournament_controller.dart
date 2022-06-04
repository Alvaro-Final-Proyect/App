import 'package:get/get.dart';
import 'package:padel/data/models/tournament_model.dart';

class TournamentController extends GetxController {
  TournamentController(TournamentModel tournamentModel){
    tournament = tournamentModel.obs;
  }

  late Rx<TournamentModel> tournament;
}