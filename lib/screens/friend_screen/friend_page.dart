import 'package:padel/screens/friend_screen/friend_controller.dart';
import 'package:padel/screens/friend_screen/user_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'friend_item.dart';
import 'friend_request_item.dart';

class FriendPage extends StatelessWidget {
  FriendPage({Key? key}) : super(key: key);

  final FriendController friendController = Get.put(FriendController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('textFriends'.tr),
          leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Icon(Icons.person_search),
              ),
              Tab(
                child: Icon(Icons.person_add),
              ),
              Tab(
                child: Icon(Icons.person),
              )
            ]
          ),
        ),
        body: FriendBody()
      )
    );
  }
}

class FriendBody extends StatelessWidget {
  FriendBody({Key? key}) : super(key: key);

  final FriendController _friendController = Get.find();

  Future<void> _refresh() async {
    await _friendController.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    _friendController.loadUsers();

    return Obx(() {
      return _friendController.isLoading() ?
        const CircularProgressIndicator() :
        TabBarView(
          children: [
            RefreshIndicator(
              child: Obx(() {
                return ListView(
                  children: _friendController.users.where((user) =>
                    user.id != _friendController.user!.id
                    && !_friendController.user!.friends!.contains(user.id)
                  ).map(
                    (user) => UserItem(UserItemController(user))
                  ).toList()
                );
              }),
              onRefresh: () async => _refresh()
            ),
            RefreshIndicator(
              child: ListView(
                children: _friendController.user!.friendsRequests!.map(
                  (userId) => FriendRequestItem(
                    FriendRequestItemController(
                      _friendController.users.firstWhereOrNull((element) => element.id == userId)!
                    )
                  )
                ).toList()
              ),
              onRefresh: () async => _refresh()
            ),
            RefreshIndicator(
              child: ListView(
                children: _friendController.users.where((user) =>
                user.id != _friendController.user!.id
                  && _friendController.user!.friends!.contains(user.id)
                ).map(
                  (user) => FriendItem(
                    FriendItemController(
                      user
                    )
                  )
                ).toList()
              ),
              onRefresh: () async => _refresh()
            )
          ],
        );
    });
  }
}