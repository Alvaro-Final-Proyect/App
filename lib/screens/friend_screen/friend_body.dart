import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/friend_screen/user_item.dart';
import 'friend_controller.dart';
import 'friend_item.dart';
import 'friend_request_item.dart';

class FriendBody extends StatelessWidget {
  FriendBody({Key? key}) : super(key: key);

  final FriendController _friendController = Get.find();

  Future<void> _refresh() async {
    await _friendController.loadUsers();
    await _friendController.updateCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    _friendController.loadUsers();

    return Obx(() {
      return _friendController.isLoading()
          ? const CircularProgressIndicator()
          : TabBarView(
              children: [
                RefreshIndicator(
                    child: Obx(() {
                      return ListView(
                          children: _friendController.users
                              .where((user) =>
                                  user.id != _friendController.user!.id &&
                                  !_friendController.user!.friends!
                                      .contains(user.id))
                              .map((user) => UserItem(UserItemController(user)))
                              .toList());
                    }),
                    onRefresh: () async => _refresh()),
                RefreshIndicator(
                    child: ListView(
                        children: _friendController.user!.friendsRequests!
                            .map((userId) => FriendRequestItem(
                                FriendRequestItemController(
                                    _friendController.users.firstWhere(
                                        (element) => element.id == userId))))
                            .toList()),
                    onRefresh: () async => _refresh()),
                RefreshIndicator(
                    child: ListView(
                        children: _friendController.users
                            .where((user) =>
                                user.id != _friendController.user!.id &&
                                _friendController.user!.friends!
                                    .contains(user.id))
                            .map((user) =>
                                FriendItem(FriendItemController(user)))
                            .toList()),
                    onRefresh: () async => _refresh())
              ],
            );
    });
  }
}
