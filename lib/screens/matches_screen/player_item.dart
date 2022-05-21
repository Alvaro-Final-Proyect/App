import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:padel/res/colors.dart';
import '../../data/models/user_response.dart';

typedef JoinToMatch = Future<void> Function(int index);

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
              backgroundImage: player.value != null ? const NetworkImage(
                  'https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'
              ) : null,
              backgroundColor: player.value == null ? Theme.of(context).colorScheme.onPrimary : null,
              child: player.value == null
                  ? Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimaryContainer)
                  : null,
            ),
            onTap: () {
              joinToMatch(index);
            },
          )
      );
    });
  }
}
