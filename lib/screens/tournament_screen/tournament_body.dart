import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';

class TournamentBody extends StatelessWidget {
  TournamentBody({Key? key}) : super(key: key);

  final _tournamentController = Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(),
    );
  }
}