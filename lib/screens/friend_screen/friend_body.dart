import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/friend_screen/friend_item.dart';
import 'package:padel/screens/friend_screen/user_item.dart';
import 'friend_controller.dart';
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
    return Obx(() {
      final noRelationUsers = _friendController.users
          .where((p0) =>
      p0.id != _friendController.user!.id &&
          !_friendController.user!.friends!.contains(p0.id))
          .toList();
      final friendsRequests = _friendController.users
          .where((p0) => _friendController.user!.friendsRequests!.contains(p0.id))
          .toList();
      final friends = _friendController.users
          .where((p0) => _friendController.user!.friends!.contains(p0.id))
          .toList();

      log('reload');

      return _friendController.isLoading()
          ? const CircularProgressIndicator()
          : TabBarView(children: [
              RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: noRelationUsers.length,
                      itemBuilder: (context, index) {
                        final user = noRelationUsers[index];
                        return UserItem(user);
                      })),
              RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: friendsRequests.length,
                      itemBuilder: (context, index) {
                        final user = friendsRequests[index];
                        return FriendRequestItem(user);
                      })),
              RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        final user = friends[index];
                        return FriendItem(user);
                      })),
            ]);
    });
  }
}
