import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:padel/util/date_time_extensions.dart';

import '../../data/models/match_model.dart';
import 'match_item.dart';
import 'matches_controller.dart';

class MatchesBody extends StatelessWidget {
  MatchesBody({Key? key}) : super(key: key);

  final matchesController = Get.find<MatchesController>();

  Future<void> _loadMatches() async {
    await matchesController.loadMatches();
    if (matchesController.loadError().isNotEmpty) {
      Fluttertoast.showToast(
        msg: matchesController.loadError(),
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Future<void> _loadPlayerMatches() async {
    await matchesController.loadPlayerMatches();
    if (matchesController.loadError().isNotEmpty) {
      Fluttertoast.showToast(
        msg: 'Could not load your matches',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadMatches();
    _loadPlayerMatches();

    return TabBarView(
      children: [
        Obx(
          () {
            return matchesController.isLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: _loadMatches,
                    child: GroupedListView<MatchModel, String>(
                      elements: matchesController.matches,
                      groupBy: (element) => element.date.getDate(),
                      groupHeaderBuilder: (MatchModel match) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Color(0xFFB7245C),
                          ),
                          child: Text(
                            '${'textDay'.tr}: ${match.date.getDate()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      itemBuilder: (_, MatchModel match) =>
                          MatchItem(match: match),
                      itemComparator: (a, b) =>
                          a.date.millisecondsSinceEpoch -
                          b.date.millisecondsSinceEpoch,
                      order: GroupedListOrder.ASC,
                      useStickyGroupSeparators: true,
                    ),
                  );
          },
        ),
        Obx(
          () {
            return RefreshIndicator(
              onRefresh: _loadMatches,
              child: GroupedListView<MatchModel, String>(
                elements: matchesController.userMatches.value,
                groupBy: (element) => element.date.getDate(),
                groupHeaderBuilder: (MatchModel match) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFB7245C),
                    ),
                    child: Text(
                      '${'textDay'.tr}: ${match.date.getDate()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                itemBuilder: (_, MatchModel match) => MatchItem(match: match),
                itemComparator: (a, b) =>
                    a.date.millisecondsSinceEpoch -
                    b.date.millisecondsSinceEpoch,
                order: GroupedListOrder.DESC,
                floatingHeader: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
