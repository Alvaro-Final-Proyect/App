import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/get_all_users_use_case.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RankingController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String error = '';

  final currentUser = RetrofitHelper.user!;

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;
  set users(value) => _users.value = value;

  final getAllUsersUseCase = GetAllUsersUseCase();

  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();


  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() async {
    isLoading = true;
    try{
      users = await getAllUsersUseCase();
      users.sort((a, b) {
        final aLevel = a.level ?? 0;
        final bLevel = b.level ?? 0;

        final difference = bLevel - aLevel;

        return difference == 0 ? 0 : difference < 0 ? -1 : 1;
      });
      error = '';
    }catch(e){
      error = 'Could not load users';
    }
    isLoading = false;
  }
}