import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/res/constants.dart';
import 'package:padel/screens/invitations_screen/invitations_controller.dart';
import 'package:padel/util/date_time_extensions.dart';

class InvitationsBody extends StatelessWidget {
  InvitationsBody({Key? key}) : super(key: key);

  final invitationsController = Get.find<InvitationsController>();

  @override
  Widget build(BuildContext context) {
    invitationsController.loadMatches();

    return Obx(
      () {
        return invitationsController.isLoading()
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: invitationsController.matches.length,
                itemBuilder: (context, index) {
                  final match = invitationsController.matches[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: match.players
                              .map(
                                (player) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    backgroundImage: player != null
                                        ? player.image == null
                                            ? Image.network(
                                                userImageUrl,
                                              ).image
                                            : Image.memory(
                                                base64Decode(
                                                  player.image!,
                                                ),
                                              ).image
                                        : null,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'textDay'.tr}: ${match.date.getDate()} - ${match.date.getHour()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${'textLevel'.tr}: ${match.minLevel} - ${match.maxLevel}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            Get.toNamed('/home/matches/match', arguments: match);
                          },
                          child: const Text('IR'),
                        ),
                    ),
                  );
                },
              );
      },
    );
  }
}
