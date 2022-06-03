import 'dart:developer';

import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/get_all_users_use_case.dart';
import 'package:padel/util/input_controllers/text_input_controller.dart';

class UpdateUserController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _selectedUser = Rx<UserModel?>(null);
  UserModel? get selectedUser => _selectedUser.value;
  set selectedUser(value) => _selectedUser.value = value;

  final _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  void toggleSearch() => isSearching = !isSearching;

  final searchInputController = TextInputController();

  final users = <UserModel>[].obs;
  final usernames = <String>[];
  final emails = <String>[];

  final getAllUsersUseCase = GetAllUsersUseCase();


  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() async {
    isLoading = true;
    try{
      users.value = await getAllUsersUseCase();
      usernames.clear();
      emails.clear();
      for (var user in users) {
        usernames.add(user.username!);
        emails.add(user.email!);
      }
      log('Users: $users, Emails: $emails, Usernames: $usernames');
    }catch(e){
      log('error: $e');
    }
    isLoading = false;
  }
}