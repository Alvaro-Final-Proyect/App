import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/tournament_screen/tournament_body.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
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
            children: match.players.mapIndexed((index, player) {
              return round == Rounds.roundOfSixteen
                  ? JoinablePlayerItem(
                player: player,
                index: index,
                match: match,
              )
                  : NotJoinablePlayerItem(
                player: player,
                index: index,
              );
            },
            ).toList(),
          ),
          if (match.winner != null)
            Text('Winner: ${'textTeam'.tr} ${match.winner! + 1}')
          else
            if (!match.players.any((element) => element == null))
              TextButton(
                onPressed: () {},
                child: Text('textSaveResult'.tr),
              ),
        ],
      ),
    );
  }
}

