import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
import 'package:padel/util/image_extensions.dart';
import 'package:padel/widgets/loading_popup.dart';

class JoinablePlayerItem extends StatelessWidget {
  JoinablePlayerItem(
      {Key? key, this.player, required this.index, required this.match})
      : super(key: key);

  final _tournamentController = Get.find<TournamentController>();
  final UserModel? player;
  final int index;
  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: player != null || _tournamentController.tournamentPlayers
          .contains(_tournamentController.currentUser.id)
          ? null
          : () {
              log('TournamentPlayers = ${_tournamentController.tournamentPlayers}\n'
                  'Player ID = ${_tournamentController.currentUser.id}\n'
                  'Is in: ${_tournamentController.tournamentPlayers.contains(_tournamentController.currentUser.id)}\n');

              LoadingPopup.show(context: context);
              _tournamentController.joinToMatch(match, index).then((value) {
                Get.back();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value
                          ? 'No te has podido unir'
                          : 'Te has unido al torneo',
                    ),
                  ),
                );
              });
            },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage:
              player != null ? ImageExtensions.fromUser(player!) : null,
          backgroundColor:
              player == null ? Get.theme.colorScheme.onSurface : null,
          child: player == null ? const Icon(Icons.add) : null,
        ),
      ),
    );
  }
}
