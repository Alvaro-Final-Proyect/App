import 'dart:developer';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/domain/tournaments_use_case/get_all_tournaments_use_case.dart';

class TournamentsController extends GetxController {


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _tournaments = <TournamentModel>[].obs;
  List<TournamentModel> get tournaments => _tournaments;
  set tournaments(value) => _tournaments.value = value;

  final getAllTournamentsUseCase = GetAllTournamentsUseCase();
  final currentUser = RetrofitHelper.user!;

  Future<bool> loadTournaments() async {
    isLoading = true;
    bool error = false;

    try{
      tournaments = await getAllTournamentsUseCase();
      log('Tournaments: $tournaments');
    }catch(e){
      log('error: $e');
      error = true;
    }

    isLoading = false;
    return !error;
  }

  @override
  void onInit() {
    super.onInit();
    loadTournaments();
  }
}