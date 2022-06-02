import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/res/colors.dart';
import 'package:padel/util/date_time_extensions.dart';

import 'administration_controller.dart';

class AdministrationBody extends StatelessWidget {
  AdministrationBody({Key? key}) : super(key: key);

  final _administrationController = Get.put(AdministrationController());

  @override
  Widget build(BuildContext context) {
    final matchesGrouped = groupBy(_administrationController.lastWeekMatches,
        (MatchModel match) => match.date.getDate());

    final data = <Map<String, dynamic>>[];

    for (final key in matchesGrouped.keys) {
      final numberOfMatches = matchesGrouped[key]!.length;
      data.add({'day': key, 'matches': numberOfMatches});
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoFormSection(
              backgroundColor: lightGray,
              header: Text('textWeeklyMatchesVolume'.tr),
              children: [
                SizedBox(
                  height: 250,
                  child: Obx(
                    () {
                      return _administrationController.lastWeekMatches.isEmpty
                          ? Center(
                              child: Text(
                                'textNoMatchesFound'.tr,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: buildLastWeekMatches(data),
                            );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Chart<Map<dynamic, dynamic>> buildLastWeekMatches(
      List<Map<String, dynamic>> data) {
    return Chart(
      data: data,
      variables: {
        'day': Variable(
          accessor: (Map map) => map['day'] as String,
        ),
        'matches': Variable(
          accessor: (Map map) => map['matches'] as num,
        ),
      },
      elements: [
        IntervalElement(
          label: LabelAttr(
            encoder: (tuple) => Label(
              tuple['matches'].toString(),
            ),
          ),
          elevation: ElevationAttr(value: 0, updaters: {
            'tap': {true: (_) => 5}
          }),
          color: ColorAttr(
            value: Defaults.primaryColor,
            updaters: {
              'tap': {false: (color) => color.withAlpha(100)}
            },
          ),
        )
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {
        'hover': PointSelection(
          dim: Dim.x,
          on: {GestureType.hover},
          clear: {GestureType.mouseExit},
        )
      },
      tooltip: TooltipGuide(),
      crosshair: CrosshairGuide(),
    );
  }
}
