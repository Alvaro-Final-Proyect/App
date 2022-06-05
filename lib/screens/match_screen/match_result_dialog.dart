import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/match_screen/match_controller.dart';
import 'package:padel/util/string_extensions.dart';
import 'package:padel/widgets/expanded_button.dart';
import 'package:padel/widgets/loading_popup.dart';

class MatchResultDialog extends StatelessWidget {
  MatchResultDialog({
    Key? key,
  }) : super(key: key);

  final team1Set1 = TextEditingController();
  final team1Set2 = TextEditingController();
  final team1Set3 = TextEditingController();
  final team2Set1 = TextEditingController();
  final team2Set2 = TextEditingController();
  final team2Set3 = TextEditingController();
  final matchController = Get.find<MatchController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Result:'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(),
          const Divider(
            height: 20,
            thickness: 1,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, left: 5),
            child: const Text('TEAM 1'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team1Set1,
                  decoration: const InputDecoration(
                    labelText: 'Set 1',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team1Set2,
                  decoration: const InputDecoration(
                    labelText: 'Set 2',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team1Set3,
                  decoration: const InputDecoration(
                    labelText: 'Set 3',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10, left: 5),
            child: const Text('TEAM 2'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team2Set1,
                  decoration: const InputDecoration(
                    labelText: 'Set 1',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team2Set2,
                  decoration: const InputDecoration(
                    labelText: 'Set 2',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 65,
                height: 40,
                child: TextFormField(
                  controller: team2Set3,
                  decoration: const InputDecoration(
                    labelText: 'Set 3',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          ExpandedButton(
            text: 'Save',
            onPressed: () {
              final team1Set1Value = team1Set1.text;
              final team1Set2Value = team1Set2.text;
              final team1Set3Value = team1Set3.text;
              final team2Set1Value = team2Set1.text;
              final team2Set2Value = team2Set2.text;
              final team2Set3Value = team2Set3.text;

              final inputs = [
                team1Set1Value,
                team1Set2Value,
                team1Set3Value,
                team2Set1Value,
                team2Set2Value,
                team2Set3Value
              ];

              if (inputs.any((element) => !element.isNumber)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Los campos solo pueden tener números o estar vacios!'),
                  ),
                );
                return;
              }

              final set1 = [
                team1Set1Value.isEmpty ? 0 : int.parse(team1Set1Value),
                team2Set1Value.isEmpty ? 0 : int.parse(team2Set1Value),
              ];
              final set2 = [
                team1Set2Value.isEmpty ? 0 : int.parse(team1Set2Value),
                team2Set2Value.isEmpty ? 0 : int.parse(team2Set2Value),
              ];
              final set3 = [
                team1Set3Value.isEmpty ? 0 : int.parse(team1Set3Value),
                team2Set3Value.isEmpty ? 0 : int.parse(team2Set3Value),
              ];

              final winner = findWinner([set1, set2, set3]);

              if (winner == -1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No se ha podido encontrar ningún ganador'),
                  ),
                );
                return;
              }

              LoadingPopup.show(context: context);

              matchController.setMatchResult(winner, [set1, set2, set3]).then((value) {
                Get.back();
                bool isSuccess = matchController.loadError().isEmpty;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isSuccess
                          ? 'Resultado guardado correctamente'
                          : 'No se ha podido guardar el resultado',
                    ),
                  ),
                );

                if(isSuccess){
                  Get.back();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  int findWinner(List<List<int>> sets) {
    int team1Counter = 0;
    int team2Counter = 0;

    for (var set in sets) {
      if (set[0] > set[1]) {
        team1Counter++;
      } else if (set[0] < set[1]) {
        team2Counter++;
      }
    }

    return team1Counter > team2Counter
        ? 0
        : team2Counter > team1Counter
            ? 1
            : -1;
  }
}
