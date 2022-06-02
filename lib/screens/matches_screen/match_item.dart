import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/matches_screen/player_item.dart';
import 'package:padel/util/date_time_extensions.dart';

import '../../data/models/match_model.dart';
import '../../widgets/pay_poup.dart';
import 'matches_controller.dart';

class MatchItem extends StatelessWidget {
  MatchItem(this._match, {Key? key,}) : super(key: key);

  final Rx<MatchModel> _match;
  MatchModel get match => _match.value;
  final matchesController = Get.find<MatchesController>();

  Future<void> _joinToMatch(int index, BuildContext context) async {
    if (match.players[index] != null) {
      return;
    }

    if (match.players.firstWhereOrNull(
            (element) => element?.id == matchesController.user.id) !=
        null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errorAlreadyJoined'.tr),
        ),
      );

      return;
    }

    matchesController.joinToMatch(_match, index).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(matchesController.loadError().isEmpty
              ? 'textJoined'.tr
              : matchesController.loadError(),
          ),
        ),
      );

      PayPopup.show(context: context);
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ha ocurrido un error inesperado'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Get.toNamed('home/matches/match', arguments: match),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          match.date.getHour(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.male),
                            Icon(Icons.female)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children:
                                    match.players.getRange(0, 2).mapIndexed(
                                  (index, player) {
                                    return PlayerItem(
                                      index: index,
                                      joinToMatch: _joinToMatch,
                                      player: player.obs,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:
                                    match.players.getRange(2, 4).mapIndexed(
                                  (index, player) {
                                    index = index + 2;
                                    return PlayerItem(
                                      player: player.obs,
                                      index: index,
                                      joinToMatch: _joinToMatch,
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${'textLevel'.tr}: ${match.minLevel} - ${match.maxLevel}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
