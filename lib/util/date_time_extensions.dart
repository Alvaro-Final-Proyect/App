import 'dart:developer';

import 'package:get/get.dart';

extension DateFormatting on DateTime {
  String format(){
    final today = DateTime.now();
    final difference = (this.difference(today).inHours / 24).round();

    switch(difference){
      case 0: return 'textToday';
      case 1: return 'textTomorrow';
      case 2: return 'textAfterTomorrow';
      default: return toLocal().getDate();
    }
  }

  String getHour() {
    final time = toLocal();
    return '${time.hour < 10 ? '0$time.hour' : time.hour}:${time.minute < 10 ? '0$time.minute' : time.minute}';
  }

  String getDate() {
    final time = toLocal();
    return '${time.day < 10 ? '0${time.day}' : time.day}/${time.month < 10 ? '0${time.month}' : time.month}/${time.year}';
  }
}