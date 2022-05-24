import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      title: Row(
                        children: match.players
                            .map((e) => e == null
                                ? const Icon(Icons.circle)
                                : const Icon(Icons.person))
                            .toList(),
                      ),
                      subtitle: Text(
                          '${'textDay'.tr}: ${match.date.getDate()}, ${'textLevel'.tr}: ${match.minLevel} - ${match.maxLevel}'),
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
