import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/matches_use_case/leave_match_use_case.dart';
import 'package:padel/domain/user_use_case/get_all_friends_use_case.dart';

import '../../domain/matches_use_case/join_to_match_use_case.dart';

class MatchController extends GetxController {
  MatchController(this.match);

  final Rx<MatchModel> match;
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final joinToMatchUseCase = JoinToMatchUseCase();
  final leaveMatchUseCase = LeaveMatchUseCase();
  final getAllFriendsUseCase = GetAllFriendsUseCase();

  final user = RetrofitHelper.user!;
  final friends = <UserModel>[].obs;

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


  Future<void> leaveMatch() async{
    _isLoading.value = true;
    try{
      match.value = await leaveMatchUseCase(match.value.id);
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Could not leave match';
    }
    _isLoading.value = false;
  }

  Future<void> loadFriends() async {
    _isLoading.value = true;
    try{
      friends.value = await getAllFriendsUseCase();
      _loadError.value = '';
    }catch(e){
      _loadError.value = 'Could not load your friends';
    }
    _isLoading.value = false;
  }
}