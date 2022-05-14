import 'package:padel/screens/home_screen/home_controller.dart';
import 'package:padel/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  Future<void> _logout() async {
    await homeController.logout();
    Get.offAllNamed('/login');
  }

  _loadUser() async {
    await homeController.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    _loadUser();

    return Scaffold(
      drawer: Obx(() => homeController.isLoading() ? const CircularProgressIndicator() : CustomDrawer()),
      appBar: AppBar(
        title: Text('homeTitle'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Obx(() => homeController.isLoading() ? const CircularProgressIndicator() : const HomeBody()),
    );
  }
}

class HomeBody extends StatelessWidget{
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}