import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/tournament_screen/match_result_dialog.dart';
import 'package:padel/screens/tournament_screen/tournament_body.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
import 'package:padel/widgets/loading_popup.dart';
import 'joinable_player_item.dart';
import 'not_joinable_player_item.dart';

class MatchItem extends StatelessWidget {
  MatchItem({
    Key? key,
    required this.match,
    required this.matchIndex,
    required this.round,
  }) : super(key: key);

  final _tournamentController = Get.find<TournamentController>();
  final MatchModel match;
  final int matchIndex;
  final Rounds round;

  @override
  Widget build(BuildContext context) {
    bool isPlayed = DateTime.now().millisecondsSinceEpoch >
        match.date.millisecondsSinceEpoch;
    bool isUserInMatch = match.players
        .any((matchPlayer) => matchPlayer?.id == _tournamentController.currentUser.id);

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...match.players.mapIndexed(
                (index, player) {
                  final playerItem = round == Rounds.roundOfSixteen
                      ? JoinablePlayerItem(
                          player: player,
                          index: index,
                          match: match,
                        )
                      : NotJoinablePlayerItem(
                          player: player,
                          index: index,
                        );

                  return player != null
                      ? Tooltip(
                          message: player.fullName,
                          child: playerItem,
                        )
                      : playerItem;
                },
              ).toList(),
              Expanded(child: Container()),
              if (isUserInMatch && !isPlayed)
                IconButton(
                  onPressed: () {
                    LoadingPopup.show(context: context);
                    _tournamentController.leaveMatch(match).then(
                      (value) {
                        Get.back();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              value
                                  ? 'No se ha podido realizar la operación'
                                  : 'Has salido del torneo',
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                  ),
                ),
            ],
          ),
          if (match.winner != null)
            Text('${'textWinner'.tr}: ${'textTeam'.tr} ${match.winner! + 1}')
          else if (!match.isEmpty &&
              _tournamentController.currentUser.isAdmin == true &&
              isPlayed)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MatchResultDialog(
                    match: match,
                    round: round,
                  ),
                );
              },
              child: Text('textSaveResult'.tr),
            ),
        ],
      ),
    );
  }
}
