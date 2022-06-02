import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/create_user_screen/create_user_controller.dart';

class CreateUserBody extends StatelessWidget {
  CreateUserBody({Key? key}) : super(key: key);

  final _updateUserController = Get.find<CreateUserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(),
    );
  }
}