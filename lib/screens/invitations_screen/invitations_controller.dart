import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/domain/user_use_case/get_invited_matches_use_case.dart';

class InvitationsController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final getInvitedMatchesUseCase = GetInvitedMatchesUseCase();

  final matches = <MatchModel>[].obs;

  Future<void> loadMatches() async {
    _isLoading.value = true;

    try{
      matches.value = await getInvitedMatchesUseCase();
      _loadError.value = '';
    }catch(e){
      _loadError.value = 'An error occurred loading matches';
    }

    _isLoading.value = false;
  }
}