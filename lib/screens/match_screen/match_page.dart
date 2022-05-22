import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/match_screen/match_controller.dart';

import 'match_body.dart';

typedef JoinToMatch = Future<void> Function(int index);

class MatchPage extends StatelessWidget {
  MatchPage({Key? key}) : super(key: key);


  final matchController =
      Get.put(MatchController((Get.arguments as MatchModel).obs));

  void _handleClick(String selection){
    switch(selection){
      case 'Challenge friend':
        if(matchController.match.value.players.firstWhereOrNull((element) => element?.id == matchController.user.id) == null){
          Fluttertoast.showToast(msg: 'For challenge you need to join first');
          return;
        }
        Get.toNamed('/home/matches/match/challenge');
        break;
      default: break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homeTitle'.tr),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Challenge friend'}.map((String choice) {
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
