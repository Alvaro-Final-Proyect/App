import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';

class TournamentsBody extends StatelessWidget {
  TournamentsBody({Key? key}) : super(key: key);

  final _tournamentsController = Get.find<TournamentsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _tournamentsController.tournaments.isEmpty
          ? const Center(
              child: Text('No tournaments found'),
            )
          : ListView.builder(
              itemCount: _tournamentsController.tournaments.length,
              itemBuilder: (BuildContext context, index) {
                final tournament = _tournamentsController.tournaments[index];
                return Text(tournament.id);
              },
            );
    });
  }
}
