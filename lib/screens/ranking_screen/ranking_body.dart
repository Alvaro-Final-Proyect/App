import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/screens/ranking_screen/ranking_controller.dart';
import 'package:padel/util/image_extensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RankingBody extends StatelessWidget {
  RankingBody({Key? key}) : super(key: key);

  final _rankingController = Get.find<RankingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _rankingController.users.isEmpty
          ? const Center(
              child: Text('No users found'),
            )
          : ScrollablePositionedList.builder(
              itemScrollController: _rankingController.itemScrollController,
              itemPositionsListener: _rankingController.itemPositionsListener,
              itemCount: _rankingController.users.length,
              itemBuilder: (context, index) {
                final user = _rankingController.users[index];
                return RankingItem(
                  user: user,
                  index: index,
                );
              },
            );
    });
  }
}

class RankingItem extends StatelessWidget {
  RankingItem({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final _rankingController = Get.find<RankingController>();
  final UserModel user;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isFriend = _rankingController.currentUser.friends!.contains(user.id);
    bool isCurrentUser = user.id == _rankingController.currentUser.id;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        leading: getLeading(),
        title: Row(
          children: [
            Text('${user.name?.capitalize} ${user.surname?.capitalize}'),
            const SizedBox(width: 10,),
            if(isFriend)
              const Icon(Icons.group)
            else if(isCurrentUser)
              const Icon(Icons.person)
          ],
        ),
        trailing: Text('${user.level ?? 0}'),
      ),
    );
  }

  Widget getLeading() {
    return index > 2
        ? Container(
            constraints: const BoxConstraints(maxWidth: 25),
            alignment: Alignment.centerLeft,
            height: double.infinity,
            child: Center(
              child: Text('${index + 1}'),
            ),
          )
        : Icon(
            index == 0 ? FontAwesomeIcons.trophy : FontAwesomeIcons.medal,
            color: index == 0
                ? const Color(0xFFffd700)
                : index == 1
                    ? const Color(0xFFC0C0C0)
                    : const Color(0xFFCD7F32),
          );
  }
}
