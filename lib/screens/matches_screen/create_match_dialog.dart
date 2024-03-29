import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/screens/matches_screen/matches_controller.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:padel/util/time_of_day_extensions.dart';
import 'package:padel/widgets/expanded_button.dart';
import 'package:padel/widgets/loading_popup.dart';

class CreateMatchDialogController extends GetxController {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
}

class CreateMatchDialog extends StatelessWidget {
  CreateMatchDialog({
    Key? key,
  }) : super(key: key);

  final matchesController = Get.find<MatchesController>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final createMatchDialogController = CreateMatchDialogController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.colorScheme.onSurface,
              onPrimary: Get.theme.colorScheme.onPrimaryContainer,
              onSurface:
                  Get.theme.colorScheme.onPrimaryContainer, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateController.text = picked.getDate();
      createMatchDialogController.selectedDate = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 30))),
    );
    if (picked != null) {
      // check hour
      timeController.text = picked.formatted;
      createMatchDialogController.selectedTime = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Center(
            child: Text(
              'textNewMatch'.tr,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: TextFormField(
                controller: dateController,
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 3.0,
                    ),
                  ),
                  labelText: 'textDay'.tr,
                  prefixIcon: const Icon(
                    Icons.date_range,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: TextFormField(
                controller: timeController,
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 3.0,
                    ),
                  ),
                  labelText: 'textHour'.tr,
                  prefixIcon: const Icon(
                    Icons.access_time,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ExpandedButton(
            text: 'textCreate'.tr,
            onPressed: () async {
              final chosenDate = createMatchDialogController.selectedDate;
              final chosenTime = createMatchDialogController.selectedTime;

              if (chosenDate == null || chosenTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Elige fecha y hora'
                    ),
                  ),
                );
                return;
              }

              DateTime selectedDate = DateTime(
                  chosenDate.year,
                  chosenDate.month,
                  chosenDate.day,
                  chosenTime.hour,
                  chosenTime.minute
              );

              if(selectedDate.isBefore(DateTime.now())){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'La fecha debe ser en el futuro'
                    ),
                  ),
                );
                return;
              }

              final offset = selectedDate.timeZoneOffset.inHours;
              log('$offset - ${selectedDate.hour} - ${selectedDate.minute}');
              selectedDate = selectedDate.subtract(Duration(hours: offset));
              log('$offset - ${selectedDate.hour} - ${selectedDate.minute}');

              final userLevel = matchesController.user.level;

              final match = MatchModel(
                id: '',
                players: [
                  matchesController.user,
                  null,
                  null,
                  null,
                ],
                minLevel: userLevel == null
                    ? 0.0
                    : (userLevel - .75).clamp(0.0, 10.0).toPrecision(2),
                date: selectedDate,
                maxLevel: userLevel == null
                    ? 10.0
                    : (userLevel + .75).clamp(0.0, 10.0).toPrecision(2),
              );

              LoadingPopup.show(context: context);

              matchesController.createMatch(match).then((value) {
                Get.back();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      matchesController.loadError().isEmpty
                          ? 'Partida creada correctamente'
                          : 'La fecha introducida no es válida',
                    ),
                  ),
                );

                if (matchesController.loadError().isEmpty) {
                  Get.back();
                }
              }).catchError((err) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ha ocurrido un error inesperado'),
                  ),
                );
              });
            },
          ),
        ],
      ),
      scrollable: true,
    );
  }
}
