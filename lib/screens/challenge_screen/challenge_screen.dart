import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        final showingFriends = matchController.friends
            .where(
              (friend) => !friend.matchesInvitations.contains(
                matchController.match.value.id,
              ),
            )
            .toList();

        return showingFriends.isEmpty
            ? Center(child: Text('textYouHaveInvitedAllYourFriends'.tr),)
            : ListView.builder(
                itemCount: showingFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = showingFriends[index];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('${user.name} ${user.surname}'),
                      subtitle:
                          Text('${user.level} - ${user.position?.capitalize}'),
                      trailing: IconButton(
                        onPressed: () async {
                          await matchController.sendMatchInvitation(user.id!);
                          if(matchController.loadError().isEmpty){
                            Fluttertoast.showToast(msg: 'textInvitationSent'.tr);
                          }else{
                            Fluttertoast.showToast(msg: 'textCouldNotSendInvitation'.tr);
                          }
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
