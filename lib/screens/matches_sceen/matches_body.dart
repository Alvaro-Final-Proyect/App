import 'package:grouped_list/grouped_list.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    _loadMatches();

    return Obx(() {
      return matchesController.isLoading() ?
      const Center(
        child: CircularProgressIndicator(),
      ) :
      RefreshIndicator(
        onRefresh: _loadMatches,
        child: GroupedListView<MatchModel, String>(
          elements: matchesController.matches,
          groupBy: (element) {
            return element.date.getDate();
          },
          groupSeparatorBuilder: (String date) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Color(0xFFB7245C)
              ),
              child: Text(
                date.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
          itemBuilder: (_, MatchModel match) => MatchItem(match: match),
          itemComparator: (a, b) => a.date.millisecondsSinceEpoch - b.date.millisecondsSinceEpoch,
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
        )
      );
    });
  }
}