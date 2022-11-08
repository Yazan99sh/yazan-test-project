import 'package:flutter/material.dart';

class TimeDifferenceCalculator {
  /// check if time1 is greater than time2
  static bool compareTo(TimeOfDay time1, TimeOfDay time2) {
    // time1 is pm, time2 is am
    if (time1.period.index > time2.period.index) {
      return true;
    }
    // time2 is pm, time1 is am
    if (time1.period.index < time2.period.index) {
      return false;
    }
    // time1 and time2 are the same period
    if (time1.hourOfPeriod == 12 && time2.hourOfPeriod < 12) {
      return false;
    }
    if (time2.hourOfPeriod == 12 && time1.hourOfPeriod < 12) {
      return true;
    }
    if (time1.hourOfPeriod > time2.hourOfPeriod) {
      return true;
    }
    if (time1.hourOfPeriod < time2.hourOfPeriod) {
      return false;
    }
    if (time1.hourOfPeriod == time2.hourOfPeriod &&
        time1.minute > time2.minute) {
      return true;
    }
    return false;
  }
}
