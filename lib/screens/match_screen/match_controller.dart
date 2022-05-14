import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:get/get.dart';

import '../../domain/matches_use_case/join_to_match_use_case.dart';

class MatchController extends GetxController {
  MatchController(this.match);

  final Rx<MatchModel> match;
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final joinToMatchUseCase = JoinToMatchUseCase();
  final user = RetrofitHelper.user!;

  Future<void> joinToMatch(int index) async {
    _isLoading.value = true;

    try{
      match.value = await joinToMatchUseCase(match.value.id, index);
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Could not join to match';
    }

    _isLoading.value = false;
  }
}