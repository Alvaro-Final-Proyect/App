import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../data/models/user_response.dart';
import '../../res/constants.dart';
import '../../widgets/loading_popup.dart';
import 'friend_controller.dart';

class FriendItem extends StatelessWidget {
  FriendItem(this._user, {Key? key}) : super(key: key);

  final friendController = Get.find<FriendController>();
  final UserModel _user;

  void _removeFriend(BuildContext context) async {
    LoadingPopup.show(context: context);

    await friendController.removeFriend(_user.id!).then((value) {
      Get.back();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            friendController.loadError().isEmpty
                ? 'Amigo eliminado correctamente'
                : 'Ha ocurrido un error al eliminar a tu amigo',
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
                    Text('Level: ${_user.level}'),
                    Text('Position: ${_user.position}'),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => _removeFriend(context),
                    child: const Text('Delete friend')
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}