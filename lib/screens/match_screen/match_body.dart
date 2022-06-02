import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/match_screen/player_item.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:padel/widgets/loading_popup.dart';

import '../../widgets/expanded_button.dart';
import '../../widgets/pay_poup.dart';
import 'match_controller.dart';
import 'match_result_dialog.dart';

class MatchBody extends StatelessWidget {
  MatchBody({Key? key}) : super(key: key);

  final matchController = Get.find<MatchController>();

  Future<void> _joinToMatch(int index, BuildContext context) async {
    if (matchController.match.value.players[index] != null) {
      return;
    }

    if (matchController.match.value.players.firstWhereOrNull(
            (element) => element?.id == matchController.user.id) !=
        null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errorAlreadyJoined'.tr),
        ),
      );
      return;
    }

    final playerLevel = matchController.user.level ?? 0;

    if (playerLevel.clamp(matchController.match.value.minLevel,
            matchController.match.value.maxLevel) !=
        playerLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tu nivel no te permite unirte'
          ),
        ),
      );

      return;
    }

    LoadingPopup.show(context: context);

    await matchController.joinToMatch(index).then((value) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            matchController.loadError().isEmpty
                ? 'textJoined'.tr
                : matchController.loadError(),
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
    log(matchController.match.value.result.toString());

    return Obx(
      () {
        return CustomScrollView(
          controller: ScrollController(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'textDay'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${matchController.match.value.date.getDate()} ${matchController.match.value.date.getHour()}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'textLevel'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${matchController.match.value.minLevel} - ${matchController.match.value.maxLevel}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${'textTeam'.tr} 1',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ...matchController.match.value.players
                                .getRange(0, 2)
                                .mapIndexed(
                              (index, player) {
                                return PlayerItem(
                                  _joinToMatch,
                                  index: index,
                                  player: player,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${'textTeam'.tr} 2',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ...matchController.match.value.players
                                .getRange(2, 4)
                                .mapIndexed(
                              (index, player) {
                                return PlayerItem(
                                  _joinToMatch,
                                  index: index + 2,
                                  player: player,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    height: 50,
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SOLO MOSTRAR ESTAS OPCIONES SI EL USUARIO ESTÁ EN LA PARTIDA
                  if (matchController.match.value.players.firstWhereOrNull(
                          (element) =>
                              element?.id == matchController.user.id) !=
                      null) ...[
                    // SI LA PARTIDA HA ACABADO Y ESTÁ COMPLETA MOSTRAR GUARDAR RESULTADO (SI NO HAY UNO YA) O MOSTRAR EL RESULTADO
                    if (matchController
                                .match.value.date.millisecondsSinceEpoch <
                            DateTime.now().millisecondsSinceEpoch &&
                        !matchController.match.value.players
                            .any((element) => element == null))
                      if (matchController.match.value.result != null &&
                          matchController.match.value.winner != null)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${'textTeam'.tr} 1',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${matchController.match.value.result![0][0]} - ${matchController.match.value.result![1][0]} - ${matchController.match.value.result![2][0]}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${'textTeam'.tr} 2',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${matchController.match.value.result![0][1]} - ${matchController.match.value.result![1][1]} - ${matchController.match.value.result![2][1]}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      else
                        ExpandedButton(
                          text: 'textSetResult'.tr,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MatchResultDialog();
                              },
                            );
                          },
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                    // SI LA PARTIDA NO SE HA JUGADO MOSTAR EL BOTÓN DE SALIR DE LA PARTIDA
                    if (matchController
                            .match.value.date.millisecondsSinceEpoch >
                        DateTime.now().millisecondsSinceEpoch)
                      ExpandedButton(
                        text: 'textLeaveGame'.tr,
                        onPressed: () async {
                          LoadingPopup.show(context: context);
                          await matchController.leaveMatch().then((value) {
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  matchController.loadError().isEmpty
                                      ? 'textYourLeftTheGame'.tr
                                      : matchController.loadError(),
                                ),
                              ),
                            );
                          });
                        },
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
