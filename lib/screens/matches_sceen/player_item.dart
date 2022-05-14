import 'package:flutter/material.dart';
import '../../data/models/user_response.dart';

typedef JoinToMatch = Future<void> Function(int index);

class PlayerItem extends StatelessWidget {
  const PlayerItem({
    Key? key, this.player, required this.index, required this.joinToMatch,
  }) : super(key: key);

  final UserModel? player;
  final int index;
  final JoinToMatch joinToMatch;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          child: CircleAvatar(
            child: player == null
              ? const Icon(Icons.add)
              : Image.network(
              'https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'
            ),
          ),
          onTap: () {
            joinToMatch(index);
          },
        )
    );
  }
}
