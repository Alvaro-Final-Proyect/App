import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/screens/tournament_screen/tournament_body.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';

class TournamentScreen extends StatelessWidget {
  TournamentScreen({Key? key}) : super(key: key);

  final _tournamentController = Get.put(TournamentController(Get.arguments as TournamentModel));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textTournament'.tr),
      ),
      body: TournamentBody(),
    );
  }
}