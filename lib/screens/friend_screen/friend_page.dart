import 'package:padel/screens/friend_screen/friend_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'friend_body.dart';

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