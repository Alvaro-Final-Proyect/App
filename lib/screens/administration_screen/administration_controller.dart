import 'dart:developer';

import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/domain/matches_use_case/get_last_week_matches_use_case.dart';

class AdministrationController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  var error = '';

  final _lastWeekMatches = <MatchModel>[].obs;
  List<MatchModel> get lastWeekMatches => _lastWeekMatches;
  set lastWeekMatches(value) => _lastWeekMatches.value = value;

  final getLastWeekMatchesUseCase = GetLastWeekMatchesUseCase();


  @override
  void onInit() {
    super.onInit();
    loadLastWeekMatches();
  }



  void loadLastWeekMatches() async {
    isLoading = true;
    try{
      lastWeekMatches = await getLastWeekMatchesUseCase();
      error = '';
    }catch(e){
      log('Error: ${e.toString()}');
      error = e.toString();
    }
    isLoading = false;
  }
}