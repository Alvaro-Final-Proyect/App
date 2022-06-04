import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_body.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';

class TournamentsScreen extends StatelessWidget {
  TournamentsScreen({Key? key}) : super(key: key);

  final _tournamentsController = Get.put(TournamentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textTournaments'.tr),
      ),
      body: Obx(() {
        return _tournamentsController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TournamentsBody();
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO CREATE TOURNAMENT
        },
        icon: const Icon(Icons.create),
        label: Text('textCreate'.tr),
      ),
    );
  }
}
