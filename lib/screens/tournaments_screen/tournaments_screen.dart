import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_body.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';

import 'create_tournament_popup.dart';

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
      floatingActionButton: _tournamentsController.currentUser.isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                CreateTournamentPopup.show(context);
              },
              icon: const Icon(Icons.create),
              label: Text('textCreate'.tr),
            )
          : null,
    );
  }
}
