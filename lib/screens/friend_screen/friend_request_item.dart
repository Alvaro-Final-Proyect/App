import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/domain/user_use_case/accept_friend_request_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../data/models/user_response.dart';

class FriendRequestItem extends StatelessWidget {
  const FriendRequestItem(this._friendRequestItemController, {Key? key}) : super(key: key);

  final FriendRequestItemController _friendRequestItemController;

  void _acceptRequest() async {
    await _friendRequestItemController.acceptFriendRequest();
    if(_friendRequestItemController.loadError() != ''){
      Fluttertoast.showToast(
        msg: _friendRequestItemController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('${_friendRequestItemController.user.name} ${_friendRequestItemController.user.surname}'),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'),
      ),
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level: ${_friendRequestItemController.user.level}'),
              Text('Position: ${_friendRequestItemController.user.position}'),
              ElevatedButton(
                onPressed: _acceptRequest,
                child: const Text('Accept Friend')
              )
            ],
          ),
        )
      ],
    );
  }
}

class FriendRequestItemController extends GetxController {
  FriendRequestItemController(this.user);

  String _textError = '';

  String loadError() => _textError;

  UserModel currentUser = RetrofitHelper.user!;
  final UserModel user;

  final AcceptFriendRequestUseCase _acceptFriendRequestUseCase = AcceptFriendRequestUseCase();

  Future<void> acceptFriendRequest() async{
    try{
      currentUser = await _acceptFriendRequestUseCase(user.id!);
      _textError = '';
    }on Exception catch(_){
      _textError = 'Friend request canceled';
      printInfo(info: 'An error occurred');
    }
  }
}