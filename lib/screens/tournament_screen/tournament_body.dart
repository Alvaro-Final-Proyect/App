import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournament_screen/match_item.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';

enum Rounds { roundOfSixteen, quarterFinals, semifinals, finalRound }

class TournamentBody extends StatelessWidget {
  TournamentBody({Key? key}) : super(key: key);

  final _tournamentController = Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          children: [
            // OCTAVOS
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: Get.theme.colorScheme.onSurface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'roundOfSixteen'.tr,
                    ),
                  ),
                  ..._tournamentController.tournament.roundOfSixteen.mapIndexed(
                    (index, match) {
                      return MatchItem(
                        match: match,
                        matchIndex: index,
                        round: Rounds.roundOfSixteen,
                      );
                    },
                  ).toList()
                ],
              ),
            ),
            // QUARTOS
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: Get.theme.colorScheme.onSurface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'quarterFinals'.tr,
                    ),
                  ),
                  ..._tournamentController.tournament.quarterFinals.mapIndexed(
                    (index, match) {
                      return MatchItem(
                        match: match,
                        matchIndex: index,
                        round: Rounds.quarterFinals,
                      );
                    },
                  ).toList()
                ],
              ),
            ),
            // SEMIS
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: Get.theme.colorScheme.onSurface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'semiFinals'.tr,
                    ),
                  ),
                  ..._tournamentController.tournament.semifinals.mapIndexed(
                    (index, match) {
                      return MatchItem(
                        match: match,
                        matchIndex: index,
                        round: Rounds.semifinals,
                      );
                    },
                  ).toList()
                ],
              ),
            ),
            // FINAL
          ],
        );
      }),
    );
  }
}


