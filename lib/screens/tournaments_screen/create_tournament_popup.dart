import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/util/input_controllers/level_input_controller.dart';
import 'package:padel/widgets/input.dart';

class CreateTournamentPopup {
  static void _showDatePicker() {}

  static void _showTimePicker() {}

  static void show(BuildContext context) {
    final dateController = TextEditingController();
    final minLevelController = LevelInputController();
    final maxLevelController = LevelInputController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('textCreateTournament'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: _showDatePicker,
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
                      onTap: _showDatePicker,
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
              ),
              const SizedBox(
                height: 5,
              ),
              Input(
                controller: maxLevelController,
                label: 'textMaxLevel'.tr,
                prefixIcon: const Icon(Icons.timeline),
              ),
            ],
          ),
        );
      },
    );
  }
}
