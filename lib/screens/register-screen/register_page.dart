import 'package:padel/screens/register-screen/register_body.dart';
import 'package:padel/screens/register-screen/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget{
  RegisterPage({Key? key}) : super(key: key);

  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('registerTitle'.tr),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: RegisterBody(),
    );
  }
}