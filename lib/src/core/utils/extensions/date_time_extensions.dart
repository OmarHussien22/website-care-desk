import 'dart:ui';

import 'package:intl/intl.dart';

import '../../../../packages_index.dart' as timeago;
import '../../services/lang/localization_services.dart';
import '../../services/lang/translate_extention.dart';
import '../general_utils.dart';

extension DateStringFormant on DateTime {
  /// Ex: "Mon 19, Apr"
  String get dayDayMonthFormat {
    try {
      return DateFormat("EEE d, MMM").format(this);
    } catch (e) {
      return "No Date Available";
    }
  }

  /// Ex: "Mon 19 Apr, 8:00 Pm"
  String get dayDayMonthHourFormat {
    try {
      return DateFormat("EEE d MMM, h:mm a").format(this);
    } catch (e) {
      return "No Date Available";
    }
  }

  /// Ex: "8:00 Pm"
  String get hourMinutes12Format {
    try {
      return DateFormat("h:mm a").format(this);
    } catch (e) {
      return "No Date Available";
    }
  }

  /// Ex: "Mon . 19 Apr . 2022"
  String get dayDayMonthYearFormat {
    try {
      Locale? language=  LocalizationServices.locale;
      return DateFormat("EEE . d MMM . yyyy",(language?.languageCode??'')).format(this);
    } catch (e) {
      printDM("Error in dayDayMonthYearFormat: $e");
      return "No Date Available";
    }
  }

  /// Ex: "2022-04-19 00:00:00"
  String get timeStampFormat {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(this);
  }
}

extension StringDateExtension on String {
  /// Ex: "2022-04-19T00:00:00.000Z"
  DateTime toDate() {
    return DateTime.tryParse(this) ?? DateTime(2001);
  }


  /// Ex: "00:00:00.000Z"
  DateTime toTime() {
    return DateTime.tryParse("2024-01-01T$this") ?? DateTime(2001);
  }

  // String formatToTimeAgo() {
  //   return timeago.format(toDate(),
  //       locale: LocalizationServices.locale?.languageCode);
  // }
}

extension StringDateDifferenceExtension on String {
  String differenceFormatted() {
      DateTime start = DateTime.parse(this);
    DateTime end = DateTime.now();

    Duration diff = start.difference(end);
    String date = '';
    int days = diff.inDays;
    int hours = diff.inHours.remainder(24);
    int minutes = diff.inMinutes.remainder(60);
    if (days != 0) {
      date = '$days ${"day".toTr()}';
    }
    if (hours != 0) {
      date = '$date, $hours ${"hour".toTr()}';
    }
    if (minutes != 0) {
      date = '$date, $minutes ${"minute".toTr()}';
    }
    return date;
  }
}
