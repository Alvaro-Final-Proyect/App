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
    log('reload req');
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
                  onPressed: () => _acceptRequest(context),
                  child: const Text('Accept Friend')
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}