import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/tournament_screen/tournament_controller.dart';
import 'package:padel/util/string_extensions.dart';
import 'package:padel/widgets/expanded_button.dart';

import '../../widgets/loading_popup.dart';

class MatchResultDialog extends StatelessWidget {
  MatchResultDialog({Key? key, required this.match}) : super(key: key);

  final tournamentController = Get.find<TournamentController>();
  final MatchModel match;
  final team1Set1Controller = TextEditingController();
  final team1Set2Controller = TextEditingController();
  final team1Set3Controller = TextEditingController();
  final team2Set1Controller = TextEditingController();
  final team2Set2Controller = TextEditingController();
  final team2Set3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('textSetResult'.tr),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${'textTeam'.tr} 1'),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: team1Set1Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 1',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: TextFormField(
                  controller: team1Set2Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 2',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: TextFormField(
                  controller: team1Set3Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 3',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 3,),
          Text('${'textTeam'.tr} 2'),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: team2Set1Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 1',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: TextFormField(
                  controller: team2Set2Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 2',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: TextFormField(
                  controller: team2Set3Controller,
                  decoration: InputDecoration(
                    labelText: 'Set 3',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 3.0)
                    ),
                    counterText: '',
                  ),
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ExpandedButton(
            onPressed: () {
              final team1Set1Value = team1Set1Controller.text;
              final team1Set2Value = team1Set2Controller.text;
              final team1Set3Value = team1Set3Controller.text;
              final team2Set1Value = team2Set1Controller.text;
              final team2Set2Value = team2Set2Controller.text;
              final team2Set3Value = team2Set3Controller.text;

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
                      'Los campos solo pueden tener números o estar vacios!',
                    ),
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

              tournamentController.setMatchResult(match, winner, [set1, set2, set3]).then((value) {
                Get.back();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value
                          ? 'No se ha podido guardar el resultado'
                          : 'Resultado guardado correctamente',
                    ),
                  ),
                );

                if(value){
                  Get.back();
                }
              });
            },
            text: 'textSave'.tr,
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
