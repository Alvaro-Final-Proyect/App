import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/update_user_screen/update_user_body.dart';
import 'package:padel/screens/update_user_screen/update_user_controller.dart';

class UpdateUserScreen extends StatelessWidget {
  UpdateUserScreen({Key? key}) : super(key: key);

  final _updateUserController = Get.put(UpdateUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: UpdateUserBody(),
    );
  }
}