import 'dart:developer';

import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/accept_friend_request_use_case.dart';
import 'package:padel/domain/user_use_case/get_all_users_use_case.dart';
import 'package:get/get.dart';
import 'package:padel/domain/user_use_case/get_user_from_token_use_case.dart';
import 'package:padel/domain/user_use_case/remove_friend_use_case.dart';
import 'package:padel/domain/user_use_case/send_friend_request_use_case.dart';

class FriendController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final getAllUsersUseCase = GetAllUsersUseCase();
  final getUserFormTokenUseCase = GetUserFromTokenUseCase();
  final sendFriendRequestUseCase = SendFriendRequestUseCase();
  final acceptFriendRequestUseCase = AcceptFriendRequestUseCase();
  final removeFriendUseCase = RemoveFriendUseCase();

  final users = <UserModel>[].obs;
  final _user = RetrofitHelper.user.obs;
  set user(value){
    RetrofitHelper.user = value;
    _user.value = value;
  }
  UserModel? get user => _user.value;

  @override
  void onInit(){
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    _isLoading.value = true;
    users.value = await getAllUsersUseCase();
    refresh();
    _isLoading.value = false;
  }

  Future<void> updateCurrentUser() async {
    _isLoading.value = true;
    user = await getUserFormTokenUseCase();
    update();
    _isLoading.value = false;
  }

  Future<void> sendFriendRequest(UserModel otherUser) async {
    try{
      await sendFriendRequestUseCase(otherUser.id!);
      _loadError.value = '';
    }on Exception catch(_){
      _loadError.value = 'Friend request canceled';
    }
  }

  Future<void> acceptFriendRequest(String userId)async {
    try{
      user = await acceptFriendRequestUseCase(userId);
      _loadError.value = '';
      update();
    }on Exception catch(_){
      _loadError.value = 'Friend request canceled';
    }
  }

  Future<void> removeFriend(String userId) async {
    try {
      user = await removeFriendUseCase(userId);
      _loadError.value = '';
      update();
    }on Exception catch(_){
      _loadError.value = 'An error occurred';
    }
  }
}