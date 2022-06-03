import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/domain/user_use_case/get_all_users_use_case.dart';
import 'package:padel/domain/user_use_case/save_user_use_case.dart';
import 'package:padel/util/input_controllers/email_input_controller.dart';
import 'package:padel/util/input_controllers/empty_input_controller.dart';
import 'package:padel/util/input_controllers/level_input_controller.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import '../../util/input_controllers/drop_down_menu_controller.dart';
import '../../util/input_controllers/username_input_controller.dart';
import '../create_user_screen/create_user_body.dart';

class UpdateUserController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _selectedUser = Rx<UserModel?>(null);
  UserModel? get selectedUser => _selectedUser.value;
  set selectedUser(value) {
    usernameController.text = value?.username ?? '';
    emailController.text = value?.email ?? '';
    nameController.text = value?.name ?? '';
    surnameController.text = value?.surname ?? '';
    levelController.text = value?.level.toString() ?? '';
    isAdminController.isChecked.value = value?.isAdmin ?? false;
    positionController.selected = Position.values.firstWhereOrNull(
          (element) {
        return element.name ==
            value!.position!;
      },
    );
    genderController.selected = Gender.values.firstWhereOrNull(
          (element) {
        return element.name ==
            value!.gender!;
      },
    );
    _selectedUser.value = value;
  }

  final _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  void toggleSearch() => isSearching = !isSearching;

  final searchInputController = TextEditingController();
  final usernameController = UsernameInputController();
  final emailController = EmailInputController();
  final nameController = EmptyInputController();
  final surnameController = EmptyInputController();
  final levelController = LevelInputController();
  final isAdminController = CheckboxController();
  final positionController = DropdownMenuController<Position>();
  final genderController = DropdownMenuController<Gender>();

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;
  set users(value) => _users.value = value;

  final usernames = <String>[];
  final emails = <String>[];

  final getAllUsersUseCase = GetAllUsersUseCase();
  final saveUserUseCase = SaveUserUseCase();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() async {
    isLoading = true;
    try{
      users = await getAllUsersUseCase();
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

  Future<bool> saveUser() async {
    try{
      await saveUserUseCase(
        selectedUser!,
      );
      final currentUser = RetrofitHelper.user!;
      if(selectedUser?.id == currentUser.id){
        currentUser.username = selectedUser!.username;
        currentUser.email = selectedUser!.email;
        currentUser.level = selectedUser!.level;
        currentUser.name = selectedUser!.name;
        currentUser.surname = selectedUser!.surname;
        currentUser.position = selectedUser!.position;
        currentUser.gender = selectedUser!.gender;
        currentUser.isAdmin = selectedUser!.isAdmin;
      }

      return true;
    }catch(e){
      log('error: e');
      return false;
    }
  }
}