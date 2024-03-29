import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:padel/widgets/loading_popup.dart';
import '../../data/models/user_response.dart';
import '../../res/constants.dart';
import 'friend_controller.dart';

class FriendRequestItem extends StatelessWidget {
  FriendRequestItem(this._user, {Key? key}) : super(key: key);

  final friendController = Get.find<FriendController>();
  final UserModel _user;

  void _acceptRequest(BuildContext context) async {
    LoadingPopup.show(context: context);
    await friendController.acceptFriendRequest(_user.id!).then((value) {
      Get.back();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            friendController.loadError().isEmpty
                ? 'Ya tienes un nuevo amigo!'
                : 'Ha ocurrido un error al aceptar la petición',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ExpansionTile(
        title: Text('${_user.name} ${_user.surname}'),
        leading: CircleAvatar(
          backgroundImage: _user.image == null
              ? Image.network(userImageUrl).image
              : Image.memory(
            base64Decode(
              _user.image!,
            ),
          ).image,
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.onSurface
            ),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Level: ${_user.roundedLevel}'),
                    Text('Position: ${_user.position}'),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => _acceptRequest(context),
                    child: const Text('Accept Friend')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}