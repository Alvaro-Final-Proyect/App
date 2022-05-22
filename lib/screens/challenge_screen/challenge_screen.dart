import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/match_screen/match_controller.dart';

import '../../res/colors.dart';

class ChallengeScreen extends StatelessWidget {
  ChallengeScreen({Key? key}) : super(key: key);

  final matchController = Get.find<MatchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge'),
        centerTitle: true,
      ),
      body: ChallengeBody(),
    );
  }
}

class ChallengeBody extends StatelessWidget {
  ChallengeBody({Key? key}) : super(key: key);

  final matchController = Get.find<MatchController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matchController.user.friends?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final user = matchController.user.friends![index];
        return Container(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: const Text('Name and Surname'),
            subtitle: const Text('Level and position'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check, color: checkGreen,)
            )
          ),
        );
      },
    );
  }
}
