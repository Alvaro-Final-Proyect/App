import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/domain/user_use_case/remove_friend_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../data/models/user_response.dart';

class FriendItem extends StatelessWidget {
  const FriendItem(this._friendItemController, {Key? key}) : super(key: key);

  final FriendItemController _friendItemController;

  void _removeFriend() async {
    printInfo(info: 'removing');
    await _friendItemController.removeFriend();
    if(_friendItemController.loadError() != ''){
      Fluttertoast.showToast(
        msg: _friendItemController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('${_friendItemController.friend.name} ${_friendItemController.friend.surname}'),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'),
      ),
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level: ${_friendItemController.friend.level}'),
              Text('Position: ${_friendItemController.friend.position}'),
              ElevatedButton(
                onPressed: _removeFriend,
                child: const Text('Delete friend')
              )
            ],
          ),
        )
      ],
    );
  }
}

class FriendItemController extends GetxController {
  FriendItemController(this.friend);

  String _textError = '';
  String loadError() => _textError;

  final UserModel friend;
  final RemoveFriendUseCase _removeFriendUseCase = RemoveFriendUseCase();

  Future<void> removeFriend() async {
    try {
      RetrofitHelper.user = await _removeFriendUseCase(friend.id!);
      _textError = '';
    }on Exception catch(_){
      _textError = 'An error occurred';
    }
  }
}