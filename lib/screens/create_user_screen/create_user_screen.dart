import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/create_user_screen/create_user_body.dart';
import 'package:padel/screens/create_user_screen/create_user_controller.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({Key? key}) : super(key: key);

  final _createUserController = Get.put(CreateUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textCreateUser'.tr),
      ),
      body: CreateUserBody(),
    );
  }
}