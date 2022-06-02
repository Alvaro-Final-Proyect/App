import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
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
    final sellsData = <Map<String, dynamic>>[];

    for (final key in matchesGrouped.keys) {
      final numberOfMatches = matchesGrouped[key]!.length;
      data.add({'day': key, 'matches': numberOfMatches});
      sellsData.add({
        'day': key,
        'amount':
            numberOfMatches * RetrofitHelper.companySettings.matchPrice * 4
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoFormSection(
              backgroundColor: Get.theme.colorScheme.onSurface,
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
                          : Container(
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: buildWeeklyMatchesVolume(data),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoFormSection(
              backgroundColor: Get.theme.colorScheme.onSurface,
              header: Text('textWeeklySellsVolume'.tr),
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
                          : Container(
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: buildWeeklySellsVolume(sellsData),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Chart<Map<dynamic, dynamic>> buildWeeklyMatchesVolume(
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
              LabelStyle(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onPrimaryContainer,
                ),
              ),
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
        AxisGuide(
          line: StrokeStyle(
            color: const Color(0xffe8e8e8),
          ),
          label: LabelStyle(
            style: TextStyle(
                color: Get.theme.colorScheme.onPrimaryContainer, fontSize: 11),
            offset: const Offset(0, 7.5),
          ),
        ),
        AxisGuide(
          label: LabelStyle(
            style: TextStyle(
                color: Get.theme.colorScheme.onPrimaryContainer, fontSize: 12),
            offset: const Offset(-7.5, 0),
          ),
          grid: StrokeStyle(
            color: const Color(0xffe8e8e8),
          ),
        ),
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

  Chart<Map<dynamic, dynamic>> buildWeeklySellsVolume(
      List<Map<String, dynamic>> data) {
    return Chart(
      data: data,
      variables: {
        'day': Variable(
          accessor: (Map map) => map['day'] as String,
        ),
        'amount': Variable(
          accessor: (Map map) => map['amount'] as double,
        ),
      },
      elements: [
        IntervalElement(
          label: LabelAttr(
            encoder: (tuple) => Label(
              '${tuple['amount']} €',
              LabelStyle(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.onPrimaryContainer,
                ),
              ),
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
        AxisGuide(
          line: StrokeStyle(
            color: const Color(0xffe8e8e8),
          ),
          label: LabelStyle(
            style: TextStyle(
              color: Get.theme.colorScheme.onPrimaryContainer,
              fontSize: 11,
            ),
            offset: const Offset(0, 7.5),
          ),
        ),
        AxisGuide(
          label: LabelStyle(
            maxLines: 1,
            style: TextStyle(
              color: Get.theme.colorScheme.onPrimaryContainer,
              fontSize: 12,
              overflow: TextOverflow.fade,
            ),
            maxWidth: 30,
            minWidth: 30,
            offset: const Offset(-7.5, 0),
          ),
          grid: StrokeStyle(
            color: const Color(0xffe8e8e8),
          ),
        ),
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
