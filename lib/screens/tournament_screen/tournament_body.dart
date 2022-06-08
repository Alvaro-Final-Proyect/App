import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournament_screen/match_item.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:padel/util/image_extensions.dart';

enum Rounds { roundOfSixteen, quarterFinals, semifinals, finalRound }

class TournamentBody extends StatelessWidget {
  TournamentBody({Key? key}) : super(key: key);

  final _tournamentController = Get.find<TournamentController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _tournamentController.tournament.finalMatch.winner == null
          ? SingleChildScrollView(
              child: Column(
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
                            '${'roundOfSixteen'.tr} - ${_tournamentController.tournament.roundOfSixteen.first.date.getDate()}',
                          ),
                        ),
                        ..._tournamentController.tournament.roundOfSixteen
                            .mapIndexed(
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
                            '${'quarterFinals'.tr} - ${_tournamentController.tournament.quarterFinals.first.date.getDate()}'
                          ),
                        ),
                        ..._tournamentController.tournament.quarterFinals
                            .mapIndexed(
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
                            '${'semiFinals'.tr} - ${_tournamentController.tournament.semifinals.first.date.getDate()}'
                          ),
                        ),
                        ..._tournamentController.tournament.semifinals
                            .mapIndexed(
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
                            '${'final'.tr} - ${_tournamentController.tournament.finalMatch.date.getDate()}',
                          ),
                        ),
                        MatchItem(
                          match: _tournamentController.tournament.finalMatch,
                          matchIndex: 0,
                          round: Rounds.finalRound,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Builder(
              builder: (context) {
                final match = _tournamentController.tournament.finalMatch;
                final players = match.players;
                final winners = players.getRange(
                    match.winner == 0 ? 0 : 2, match.winner == 0 ? 2 : 4);
                final losers = players.getRange(
                    match.winner == 0 ? 2 : 0, match.winner == 0 ? 4 : 2);

                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Text(
                              'textTournamentFinished'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.onPrimary
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.trophy,
                                    color: Colors.yellow,
                                    size: 80,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: winners.map(
                                      (player) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    ImageExtensions.fromUser(
                                                        player!),
                                              ),
                                              const SizedBox(width: 5,),
                                              Text(player.fullName),
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.onPrimary
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.trophy,
                                    color: Color(0xFFC0C0C0),
                                    size: 80,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: losers.map(
                                          (player) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                ImageExtensions.fromUser(
                                                    player!),
                                              ),
                                              const SizedBox(width: 5,),
                                              Text(player.fullName),
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // FOOTER
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(),
                      ),
                    ],
                  ),
                );
              },
            );
    });
  }
}
