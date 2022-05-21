import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_response.dart';
import 'match_controller.dart';
import 'match_page.dart';

class PlayerItem extends StatelessWidget {
  PlayerItem(this.joinToMatch, {Key? key, required this.index, this.player}) : super(key: key);

  final matchController = Get.find<MatchController>();
  final int index;
  final UserModel? player;
  final JoinToMatch joinToMatch;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundImage: player != null ? const NetworkImage(
                      'https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'
                  ) : null,
                  backgroundColor: player == null ? Theme.of(context).colorScheme.onPrimary : null,
                  child: player == null
                      ? Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimaryContainer)
                      : null,
                ),
                onTap: () {
                  joinToMatch(index);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(player != null ? '${player?.name} (${player?.position})' : 'Empty'),
              Text(player != null ? 'Level: ${player?.level}' : '')
            ],
          ),
        )
      ),
    );
  }
}