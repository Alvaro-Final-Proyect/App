import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';

class TournamentsBody extends StatelessWidget {
  TournamentsBody({Key? key}) : super(key: key);

  final _tournamentsController = Get.find<TournamentsController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, index) {
        return Container();
      },
    );
  }
}
