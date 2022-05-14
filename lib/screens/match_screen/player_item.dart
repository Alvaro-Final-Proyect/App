import 'package:flutter/cupertino.dart';
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
                  backgroundImage: player == null
                      ? const NetworkImage('http://knttraining.co.uk/wp-content/uploads/2018/11/how-to-add-a-png-to-a-photo-300x300.png')
                      : const NetworkImage('https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'),
                  backgroundColor: Colors.white,
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