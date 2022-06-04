import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';
import 'package:padel/util/date_time_extensions.dart';

class TournamentsBody extends StatelessWidget {
  TournamentsBody({Key? key}) : super(key: key);

  final _tournamentsController = Get.find<TournamentsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _tournamentsController.tournaments.isEmpty
            ? const Center(
                child: Text('No tournaments found'),
              )
            : ListView.builder(
                itemCount: _tournamentsController.tournaments.length,
                itemBuilder: (BuildContext context, index) {
                  final tournament = _tournamentsController.tournaments[index];
                  final startMatch = tournament.roundOfSixteen.first;
                  final startDate = startMatch.date;
                  final minLevel = startMatch.minLevel;
                  final maxLevel = startMatch.maxLevel;
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed('/home/tournaments/tournament',
                            arguments: tournament);
                      },
                      title: Text(
                          '${startDate.getDate()} - ${startDate.getHour()}'),
                      subtitle: Text('${'textLevel'.tr} $minLevel - $maxLevel'),
                      trailing: const Icon(FontAwesomeIcons.rankingStar),
                    ),
                  );
                },
              );
      },
    );
  }
}
