import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:padel/util/date_time_extensions.dart';

import '../../data/models/match_model.dart';
import 'match_item.dart';
import 'matches_controller.dart';

class MatchesBody extends StatelessWidget {
  MatchesBody({Key? key}) : super(key: key);

  final matchesController = Get.find<MatchesController>();

  Future<void> _loadMatches(BuildContext context) async {
    matchesController.loadMatches().then((value) {
      if (matchesController.loadError().isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hemos podido cargar las partidas'),
          ),
        );
      }
    });
  }

  Future<void> _loadPlayerMatches(BuildContext context) async {
    matchesController.loadPlayerMatches().then((value) {
      if (matchesController.loadError().isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No hemos podido cargar tu historial de partidas'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadMatches(context);
    _loadPlayerMatches(context);

    return Obx(
      () {
        return matchesController.isLoading()
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  RefreshIndicator(
                    onRefresh: () async => _loadMatches(context),
                    child: Obx(() {
                      return GroupedListView<MatchModel, String>(
                        elements: matchesController.matches.value,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        itemBuilder: (_, MatchModel match) =>
                            MatchItem(match.obs),
                        itemComparator: (a, b) =>
                            a.date.millisecondsSinceEpoch -
                            b.date.millisecondsSinceEpoch,
                        order: GroupedListOrder.ASC,
                        useStickyGroupSeparators: true,
                      );
                    }),
                  ),
                  Obx(
                    () {
                      return RefreshIndicator(
                        onRefresh: () async => _loadPlayerMatches(context),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          itemBuilder: (_, MatchModel match) =>
                              MatchItem(match.obs),
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
      },
    );
  }
}
