import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/match_screen/match_controller.dart';

import 'match_body.dart';

typedef JoinToMatch = Future<void> Function(int index, BuildContext context);

class MatchPage extends StatelessWidget {
  MatchPage({Key? key}) : super(key: key);


  final matchController =
      Get.put(MatchController((Get.arguments as MatchModel).obs));

  void _handleClick(_){
    if(matchController.match.value.players.firstWhereOrNull((element) => element?.id == matchController.user.id) == null){
      Fluttertoast.showToast(msg: 'textYouNeedToJoin'.tr);
      return;
    }
    Get.toNamed('/home/matches/match/challenge');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homeTitle'.tr),
        centerTitle: true,
        actions: [
          if(matchController.match.value.date.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch)
            PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'textChallengeFriend'.tr}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: MatchBody(),
    );
  }
}
