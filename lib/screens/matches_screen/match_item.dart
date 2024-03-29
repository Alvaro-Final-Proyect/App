import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/matches_screen/player_item.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:padel/widgets/loading_popup.dart';

import '../../data/models/match_model.dart';
import '../../widgets/pay_poup.dart';
import 'matches_controller.dart';

class MatchItem extends StatelessWidget {
  MatchItem(
    this._match, {
    Key? key,
  }) : super(key: key);

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

    final playerLevel = matchesController.user.level ?? 0;

    if (playerLevel.clamp(match.minLevel, match.maxLevel) != playerLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tu nivel no te permite unirte'),
        ),
      );

      return;
    }

    LoadingPopup.show(context: context);

    matchesController.joinToMatch(_match, index).then((value) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            matchesController.loadError().isEmpty
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
        onTap: () async {
          await Get.toNamed('home/matches/match', arguments: match);
          matchesController.loadMatches();
          matchesController.loadPlayerMatches();
        },
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
                        child: AutoSizeText(
                          match.date.getHour(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 5,
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
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: match.players.getRange(0, 2).mapIndexed(
                                    (index, player) {
                                  return PlayerItem(
                                    index: index,
                                    joinToMatch: _joinToMatch,
                                    player: player.obs,
                                  );
                                },
                              ).toList(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: match.players.getRange(2, 4).mapIndexed(
                                    (index, player) {
                                  index = index + 2;
                                  return PlayerItem(
                                    player: player.obs,
                                    index: index,
                                    joinToMatch: _joinToMatch,
                                  );
                                },
                              ).toList(),
                            )
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
