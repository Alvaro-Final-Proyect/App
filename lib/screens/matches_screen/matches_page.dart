import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_match_dialog.dart';
import 'matches_body.dart';
import 'matches_controller.dart';

class MatchesPage extends StatelessWidget {
  MatchesPage({Key? key}) : super(key: key);

  final matchesController = Get.put(MatchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textMatches'.tr),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: MatchesBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => CreateMatchDialog(),
          );
          matchesController.loadMatches();
        },
        label: Text('textCreate'.tr),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
