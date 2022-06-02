import 'dart:developer';

import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/domain/matches_use_case/create_match_use_case.dart';
import 'package:padel/domain/matches_use_case/get_all_matches_use_case.dart';
import 'package:padel/domain/matches_use_case/join_to_match_use_case.dart';
import 'package:get/get.dart';
import 'package:padel/domain/matches_use_case/leave_match_use_case.dart';
import 'package:padel/domain/user_use_case/get_user_matches_use_case.dart';

class MatchesController extends GetxController {

  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final getAllMatchesUseCase = GetAllMatchesUseCase();
  final joinToMatchUseCase = JoinToMatchUseCase();
  final createMatchUseCase = CreateMatchUseCase();
  final getUserMatchesUseCase = GetUserMatchesUseCase();

  final RxList<MatchModel> matches = <MatchModel>[].obs;
  final user = RetrofitHelper.user!;
  final companySettings = RetrofitHelper.companySettings;
  final userMatches = <MatchModel>[].obs;

  Future<void> loadMatches() async {
    _isLoading.value = true;

    try{
      final matchesLoaded = (await getAllMatchesUseCase()).where((element) {
        final today = DateTime.now();
        final difference = (element.date.difference(today).inHours / 24).round();
        return difference >= 0 && difference < 3;
      }).toList();
      matches.value = matchesLoaded;
      _loadError.value = '';
    }catch(e){
      _loadError.value = 'Could not load matches';
    }

    _isLoading.value = false;
  }

  Future<void> joinToMatch(Rx<MatchModel> match, int index) async {
    try{
      final matchUpdated = await joinToMatchUseCase(match.value.id, index);
      match.update((val) {
        val?.players = matchUpdated.players;
      });
      matches.refresh();
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Could not join to match';
    }
  }

  Future<void> createMatch(MatchModel match) async {
    try{
      final matchCreated = await createMatchUseCase(match);
      matches.add(matchCreated);
      matches.refresh();
      _loadError.value = '';
    }catch(e){
      _loadError.value = 'Could not create match';
    }
  }

  Future<void> loadPlayerMatches() async {
    _isLoading.value = true;

    try{
      final matches = await getUserMatchesUseCase();
      userMatches.value = matches;
      _loadError.value = '';
    }catch(e){
      log('$e, ${e.runtimeType}');
      _loadError.value = 'Could not load your matches';
    }

    _isLoading.value = false;
  }
}