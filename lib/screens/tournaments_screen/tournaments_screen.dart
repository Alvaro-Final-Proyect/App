import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/res/colors.dart';

import '../../util/image_extensions.dart';

class TournamentsPage extends StatelessWidget {
  TournamentsPage({Key? key}) : super(key: key);

  final tournament = <String, List<MatchModel?>>{
    'roundOfSixteen': [
      MatchModel(
        id: 'id',
        players: [
          UserModel(matchesInvitations: []),
          UserModel(matchesInvitations: []),
          UserModel(matchesInvitations: []),
          UserModel(matchesInvitations: []),
        ],
        minLevel: 3.0,
        date: DateTime.now(),
        maxLevel: 4.0,
      ),
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ],
    'quarterFinals': [
      null,
      null,
      null,
      null,
    ],
    'semiFinals': [
      null,
      null,
    ],
    'final': [
      null,
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textTournaments'.tr),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tournament.keys.length,
        itemBuilder: (context, index) {
          final key = tournament.keys.elementAt(index);
          final matches = tournament[key]!;
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(key.tr),
              subtitle: Column(
                children: matches.map(
                  (match) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: white,
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      child: isJoinableMatch(match, key)
                          ? const EmptyMatch()
                          : match == null
                              ? const Center(
                                  child: Text('?'),
                                )
                              : NotEmptyMatch(
                                  match: match,
                                ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isJoinableMatch(MatchModel? match, String key) =>
      (match == null || match.isEmpty) && key == 'roundOfSixteen';
}

class NotEmptyMatch extends StatelessWidget {
  const NotEmptyMatch({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    final team1 = match.players.getRange(0, 2);
    final team2 = match.players.getRange(2, 4);

    return Wrap(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  ...team1.map((e) => CircleAvatar(backgroundImage: ImageExtensions.fromUser(e!,),),).toList(),
                  ...team2.map((e) => CircleAvatar(backgroundImage: ImageExtensions.fromUser(e!,),),).toList(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        AutoSizeText('Winner: ${match.winnerText}', overflow: TextOverflow.fade,),
      ],
    );
  }
}

class EmptyMatch extends StatelessWidget {
  const EmptyMatch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text('Empty match'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'JOIN!',
          ),
        )
      ],
    );
  }
}
