import 'package:padel/screens/profile_screen/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({Key? key}) : super(key: key);

  void _save(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('titleProfile'.tr),
        leading: IconButton(
          onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)
        ),
        centerTitle: true,
      ),
      body: ProfileBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: const Icon(Icons.check),
      ),
    );
  }
}