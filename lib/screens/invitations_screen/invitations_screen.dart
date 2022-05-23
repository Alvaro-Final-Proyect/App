import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'invitations_body.dart';
import 'invitations_controller.dart';

class InvitationsScreen extends StatelessWidget {
  InvitationsScreen({Key? key}) : super(key: key);

  final invitationsController = Get.put(InvitationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textInvitations'.tr),
      ),
      body: InvitationsBody(),
    );
  }
}