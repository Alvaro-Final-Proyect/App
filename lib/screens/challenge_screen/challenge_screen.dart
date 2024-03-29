import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/screens/match_screen/match_controller.dart';
import 'package:padel/widgets/loading_popup.dart';

import '../../res/colors.dart';
import '../../res/constants.dart';

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
              (friend) =>
                  matchController.match.value.players.firstWhereOrNull(
                          (element) => element?.id == friend.id) ==
                      null &&
                  !friend.matchesInvitations.contains(
                    matchController.match.value.id,
                  ),
            )
            .toList();

        return showingFriends.isEmpty
            ? Center(
                child: Text('textYouHaveInvitedAllYourFriends'.tr),
              )
            : ListView.builder(
                itemCount: showingFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = showingFriends[index];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text('${user.name} ${user.surname}'),
                      subtitle:
                          Text('${user.roundedLevel} - ${user.position?.capitalize}'),
                      trailing: IconButton(
                        onPressed: () async {
                          LoadingPopup.show(context: context);

                          await matchController.sendMatchInvitation(user.id!).then((value) {
                            Get.back();
                            final isSuccess = matchController.loadError().isEmpty;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isSuccess
                                      ? 'textInvitationSent'.tr
                                      : 'textCouldNotSendInvitation'.tr,
                                ),
                              ),
                            );

                          });
                        },
                        icon: const Icon(
                          Icons.check,
                          color: checkGreen,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: user.image == null
                            ? Image.network(userImageUrl).image
                            : Image.memory(
                          base64Decode(
                            user.image!,
                          ),
                        ).image,
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
