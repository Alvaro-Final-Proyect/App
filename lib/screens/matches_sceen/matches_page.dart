import 'package:padel/screens/matches_sceen/matches_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'matches_body.dart';

class MatchesPage extends StatelessWidget {
  MatchesPage({Key? key}) : super(key: key);

  final matchesController = Get.put(MatchesController());

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
      body: MatchesBody(),
    );
  }
}