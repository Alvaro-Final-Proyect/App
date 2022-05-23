import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/screens/matches_screen/player_item.dart';
import 'package:padel/util/date_time_extensions.dart';
import '../../data/models/match_model.dart';
import 'matches_controller.dart';

class MatchItem extends StatelessWidget {
  MatchItem({Key? key, required this.match}) : super(key: key);

  final MatchModel match;
  final matchesController = Get.find<MatchesController>();

  Future<void> _joinToMatch(int index) async {
    if (match.players[index] != null) {
      return;
    }

    if (match.players.firstWhereOrNull(
            (element) => element?.id == matchesController.user.id) !=
        null) {
      Fluttertoast.showToast(
          msg: 'errorAlreadyJoined'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.white38);
      return;
    }

    await matchesController.joinToMatch(match, index);
    if (matchesController.loadError() != '') {
      Fluttertoast.showToast(msg: matchesController.loadError());
    } else {
      Fluttertoast.showToast(msg: 'textJoined'.tr);
    }
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
                        child: Center(
                          child: Text(
                            match.date.getHour(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.yellow),
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
