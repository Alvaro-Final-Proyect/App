import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/get_all_users_use_case.dart';
import 'package:get/get.dart';

class FriendController extends GetxController {
  final _isLoading = false.obs;
  final _loadError = ''.obs;

  bool isLoading() => _isLoading.value;
  String loadError() => _loadError.value;

  final getAllUsersUseCase = GetAllUsersUseCase();
  final users = <UserModel>[].obs;
  final showingUsers = <UserModel>[].obs;
  final user = RetrofitHelper.user;

  Future<void> loadUsers() async {
    _isLoading.value = true;
    users.value = await getAllUsersUseCase();
    showingUsers.value = users;
    _isLoading.value = false;
  }
}