import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/screens/match_screen/player_item.dart';
import 'package:padel/util/date_time_extensions.dart';
import '../../widgets/expanded_button.dart';
import 'match_controller.dart';
import 'match_result_dialog.dart';

class MatchBody extends StatelessWidget {
  MatchBody({Key? key}) : super(key: key);

  final matchController = Get.find<MatchController>();

  Future<void> _joinToMatch(int index) async{
    if(matchController.match.value.players[index] != null){
      return;
    }

    if(matchController.match.value.players.firstWhereOrNull((element) => element?.id == matchController.user.id) != null){
      Fluttertoast.showToast(
          msg: 'You are already joined to the match',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.white38
      );
      return;
    }

    await matchController.joinToMatch(index);
    if(matchController.loadError() != ''){
      Fluttertoast.showToast(msg: matchController.loadError());
    }else{
      Fluttertoast.showToast(msg: 'Joined');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                            'Date',
                            style: TextStyle(fontSize: 18,)
                        )
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${matchController.match.value.date.getDate()} ${matchController.match.value.date.getHour()}',
                        style: const TextStyle(fontSize: 18,),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Level',
                        style: TextStyle(fontSize: 18,)
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${matchController.match.value.minLevel} - ${matchController.match.value.maxLevel}',
                        style: const TextStyle(fontSize: 18,)
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 2,),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Team 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                        ...matchController.match.value.players.getRange(0, 2).mapIndexed((index, player) {
                          return PlayerItem(_joinToMatch, index: index, player: player,);
                        })
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Team 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,)),
                        ...matchController.match.value.players.getRange(2, 4).mapIndexed((index, player) {
                          return PlayerItem(_joinToMatch, index: index + 2, player: player);
                        })
                      ]
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2, height: 50,),
              Expanded(child: Container(),),
              if(matchController.match.value.players.firstWhereOrNull((element) => element?.id == matchController.user.id) != null)
                ...[
                  ExpandedButton(
                      text: 'Set result',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const MatchResultDialog();
                            }
                        );
                      },
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      )
                  ),
                  ExpandedButton(
                      text: 'Leave game',
                      onPressed: () {},
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      )
                  )
                ]
            ],
          ),
        )
      ],
    );
  }
}