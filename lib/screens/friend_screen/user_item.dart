import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/models/user_response.dart';
import '../../res/constants.dart';
import 'friend_controller.dart';

class UserItem extends StatelessWidget {
  UserItem(this._user, {Key? key}) : super(key: key);

  final friendController = Get.find<FriendController>();
  final UserModel _user;

  void _sendRequest() async {
    await friendController.sendFriendRequest(_user.id!);
    if (friendController.loadError() != '') {
      Fluttertoast.showToast(
        msg: friendController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
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
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Level: ${_user.level}'),
                Text('Position: ${_user.position}'),
                ElevatedButton(
                  onPressed: _sendRequest,
                  child: const Text('Request friend'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
