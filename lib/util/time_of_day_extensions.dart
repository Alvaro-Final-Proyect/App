import 'package:flutter/material.dart';

extension DateFormatting on TimeOfDay {
  String get formatted => '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
}