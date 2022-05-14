import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/domain/user_use_case/send_friend_request_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../data/models/user_response.dart';

class UserItem extends StatelessWidget {
  const UserItem(this._userItemController, {Key? key}) : super(key: key);

  final UserItemController _userItemController;
  void _sendRequest() async {
    await _userItemController.sendFriendRequest();
    if(_userItemController.loadError() != ''){
      Fluttertoast.showToast(
        msg: _userItemController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('${_userItemController.user.name} ${_userItemController.user.surname}'),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'),
      ),
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level: ${_userItemController.user.level}'),
              Text('Position: ${_userItemController.user.position}'),
              ElevatedButton(
                onPressed: _sendRequest,
                child: const Text('Request friend')
              )
            ],
          ),
        )
      ],
    );
  }
}

class UserItemController extends GetxController {
  UserItemController(this.user);

  String _textError = '';

  String loadError() => _textError;

  final currentUser = RetrofitHelper.user!;
  final UserModel user;

  final SendFriendRequestUseCase _sendFriendRequestUseCase = SendFriendRequestUseCase();

  Future<void> sendFriendRequest() async{
    try{
      _sendFriendRequestUseCase(user.id!);
      _textError = '';
    }on Exception catch(_){
      _textError = 'Friend request canceled';
      printInfo(info: 'An error occurred');
    }
  }
}