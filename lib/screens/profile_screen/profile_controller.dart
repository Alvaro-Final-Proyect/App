import 'package:padel/core/retrofit_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final currentUser = RetrofitHelper.user;

  Future<void> save(String username, String email, String name, String surname,
      String position) async {

    currentUser?.username = username;
    currentUser?.email = email;
    currentUser?.name = name;
    currentUser?.surname = surname;
    currentUser?.position = position;
  }
}
