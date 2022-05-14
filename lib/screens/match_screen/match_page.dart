import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/match_screen/match_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'match_body.dart';

typedef JoinToMatch = Future<void> Function(int index);

class MatchPage extends StatelessWidget {
  MatchPage({Key? key}) : super(key: key);

  final matchController = Get.put(MatchController((Get.arguments as MatchModel).obs));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homeTitle'.tr),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: MatchBody(),
    );
  }
}