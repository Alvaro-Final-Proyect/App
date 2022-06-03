import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/update_user_screen/update_user_controller.dart';
import 'package:padel/widgets/input.dart';

class UpdateUserBody extends StatelessWidget {
  UpdateUserBody({Key? key}) : super(key: key);

  final _updateUserController = Get.find<UpdateUserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            return _updateUserController.isSearching
                ? Input(
                    padding: const EdgeInsets.all(20),
                    label: 'textUsername'.tr,
                    prefixIcon: const Icon(Icons.person),
                  )
                : Container();
          }),
        ],
      ),
    );
  }
}
