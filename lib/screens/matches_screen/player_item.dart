import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../data/models/user_response.dart';
import '../../res/constants.dart';

typedef JoinToMatch = void Function(int index, BuildContext context);

class PlayerItem extends StatelessWidget {
  const PlayerItem({
    Key? key, required this.player, required this.index, required this.joinToMatch,
  }) : super(key: key);

  final Rx<UserModel?> player;
  final int index;
  final JoinToMatch joinToMatch;

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            child: CircleAvatar(
              backgroundImage: player.value != null ? player.value?.image == null
                  ? Image.network(userImageUrl).image
                  : Image.memory(
                base64Decode(
                  player.value!.image!,
                ),
              ).image : null
              ,
              backgroundColor: player.value == null ? Theme.of(context).colorScheme.onPrimary : null,
              child: player.value == null
                  ? Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimaryContainer)
                  : null,
            ),
            onTap: () {
              joinToMatch(index, context);
            },
          )
      );
    });
  }
}