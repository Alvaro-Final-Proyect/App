import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/screens/tournaments_screen/tournaments_controller.dart';
import 'package:padel/util/date_time_extensions.dart';
import 'package:padel/util/input_controllers/level_input_controller.dart';
import 'package:padel/util/time_of_day_extensions.dart';
import 'package:padel/widgets/expanded_button.dart';
import 'package:padel/widgets/input.dart';
import 'package:padel/widgets/loading_popup.dart';

class CreateTournamentPopup extends StatelessWidget {
  CreateTournamentPopup({Key? key}) : super(key: key);

  final _tournamentsController = Get.find<TournamentsController>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final minLevelController = LevelInputController();
  final maxLevelController = LevelInputController();

  static Future<DateTime?> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
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

    return picked;
  }

  static Future<TimeOfDay?> _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    // TODO: implement build
    return AlertDialog(
      title: Text('textCreateTournament'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: InkWell(
                  onTap: () async {
                    final picked = await _showDatePicker(context);
                    if (picked != null) {
                      selectedDate = picked;
                      dateController.text = selectedDate!.getDate();
                    }
                    log('date: $selectedDate');
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
                width: 5,
              ),
              Flexible(
                child: InkWell(
                  onTap: () async {
                    final picked = await _showTimePicker(context);
                    if (picked != null) {
                      selectedTime = picked;
                      timeController.text = selectedTime!.formatted;
                    }
                    log('time: $selectedTime');
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
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Input(
            controller: minLevelController,
            label: 'textMinLevel'.tr,
            prefixIcon: const Icon(Icons.timeline),
            onChanged: (value) {
              minLevelController.onChanged(value);
              minLevelController.validate();
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Input(
            controller: maxLevelController,
            label: 'textMaxLevel'.tr,
            prefixIcon: const Icon(Icons.timeline),
            onChanged: (value) {
              maxLevelController.onChanged(value);
              maxLevelController.validate();
            },
          ),
          ExpandedButton(
            text: 'textCreate'.tr,
            onPressed: () => createTournament(
              context,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
            ),
          ),
        ],
      ),
    );
  }

  void createTournament(
    BuildContext context, {
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    if (selectedDate == null) {
      return;
    }

    if (selectedTime == null) {
      return;
    }

    final validations = [
      minLevelController.validate(),
      maxLevelController.validate()
    ];

    if (validations.contains(false)) {
      return;
    }

    final minLevel = double.parse(minLevelController.text);
    final maxLevel = double.parse(maxLevelController.text);

    if (minLevel > maxLevel) {
      return;
    }

    final date = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final body = {
      'startDate': date.toIso8601String(),
      'minLevel': minLevel,
      'maxLevel': maxLevel,
    };

    LoadingPopup.show(context: context);
    _tournamentsController.createTournament(body).then((value) {
      Get.back();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value ? 'No se ha podido crear el torneo' : 'Torneo creado correctamente'
          ),
        ),
      );

      if(!value){
        Get.back();
      }
    });
  }
}
