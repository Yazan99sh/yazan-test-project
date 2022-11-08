import 'package:flutter/material.dart';

extension TimeOfDayFormatter on TimeOfDay {
  String getTotalTimeWorked() {
    return '${hour + (minute ~/ 60)} h ${(minute % 60).toInt()} m';
  }
}
