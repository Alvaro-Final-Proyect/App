import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/ranking_screen/ranking_body.dart';
import 'package:padel/screens/ranking_screen/ranking_controller.dart';

class RankingScreen extends StatelessWidget {
  RankingScreen({Key? key}) : super(key: key);

  final _rankingController = Get.put(RankingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        actions: [
          IconButton(
            onPressed: () {
              final currentUserIndex = _rankingController.users.indexWhere(
                (element) => element.id == _rankingController.currentUser.id,
              );

              if (currentUserIndex != -1) {
                _rankingController.itemScrollController.scrollTo(
                  index: currentUserIndex,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOutCubic,
                );
              }
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(() {
        return _rankingController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RankingBody();
      }),
    );
  }
}
