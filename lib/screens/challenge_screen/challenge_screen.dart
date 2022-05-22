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
    matchController.loadFriends();

    return Obx(
      () {
        return matchController.isLoading()
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: matchController.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = matchController.friends[index];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('${user.name} ${user.surname}'),
                      subtitle:
                          Text('${user.level} - ${user.position?.capitalize}'),
                      trailing: IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(
                          Icons.check,
                          color: checkGreen,
                        ),
                      ),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png',
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
