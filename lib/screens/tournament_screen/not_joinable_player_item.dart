import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
import 'package:padel/util/image_extensions.dart';

class NotJoinablePlayerItem extends StatelessWidget {
  NotJoinablePlayerItem({Key? key, this.player, required this.index}) : super(key: key);

  final _tournamentController = Get.find<TournamentController>();
  final UserModel? player;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage:
        player != null ? ImageExtensions.fromUser(player!) : null,
        backgroundColor:
        player == null ? Get.theme.colorScheme.onSurface : null,
      ),
    );
  }
}
