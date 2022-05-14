import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/domain/matches_use_case/get_all_matches_use_case.dart';
import 'package:padel/domain/matches_use_case/join_to_match_use_case.dart';
import 'package:get/get.dart';

class MatchesController extends GetxController {

  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final getAllMatchesUseCase = GetAllMatchesUseCase();
  final joinToMatchUseCase = JoinToMatchUseCase();

  var matches = <MatchModel>[];
  final user = RetrofitHelper.user!;

  Future<void> loadMatches() async {
    _isLoading.value = true;

    try{
      matches = (await getAllMatchesUseCase()).where((element) {
        final today = DateTime.now();
        final difference = (element.date.difference(today).inHours / 24).round();
        return difference >= 0 && difference < 3;
      }).toList();
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Could not load matches';
    }

    _isLoading.value = false;
  }

  Future<void> joinToMatch(MatchModel match, int index) async {
    _isLoading.value = true;

    try{
      match = await joinToMatchUseCase(match.id, index);
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Could not join to match';
    }

    refresh();
    _isLoading.value = false;
  }
}