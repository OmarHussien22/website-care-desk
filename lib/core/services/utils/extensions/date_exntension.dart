
import '../../lang_service/translate_extention.dart';
import '../general_utils.dart';
import 'package:intl/intl.dart';

extension DateFormant on DateTime {
  /// Ex: "Mon, 19, Apr"
  String get dayDayMonthFormat {
    try {
      return DateFormat("EEE d, MMM").format(this);
    } catch (e) {
      printDM("Error: $e", name: "DateFormant");
      return "No Date Found";
    }
  }

  /// Ex: "Apr 19, 2023"
  String get monthDayYearFormat {
    try {
      return DateFormat("MMM d, yyyy").format(this);
    } catch (e) {
      printDM("Error: $e", name: "DateFormant");
      return "No Date Found";
    }
  }

  /// Ex: "12 Janery"
  String get dayMonthFormat {
    try {
      return DateFormat("d MMM").format(this);
    } catch (e) {
      printDM("Error: $e", name: "DateFormant");
      return "No Date Found";
    }
  }

  /// Ex: "Apr 19, 2023 12:00 PM"
  String get monthDayYearHourMinuteFormat {
    try {
      return DateFormat("MMM d, yyyy hh:mm a").format(this);
    } catch (e) {
      printDM("Error: $e", name: "DateFormant");
      return "No Date Found";
    }
  }

  /// Ex: "12:00 PM"
  String get hourMinute12Format {
    try {
      
      return DateFormat("hh:mm a").format(this);
    } catch (e) {
      printDM("Error: $e", name: "DateFormant");
      return "No Date Found";
    }
  }

  /// Ex: "2023-04-19"
  String get yearMonthDayFormat {
    try {
      return DateFormat("dd-MM-yyyy").format(this);
    } catch (e) {
      printDM("Error: $e for ", name: "DateFormant");
      return "No Date Found";
    }
  }
}

extension DateParsing on String {
  /// Ex: "2023-04-19 12:00:00"
  DateTime toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      printDM("Date ${toString()} , ${e.toString()}}",
          name: "DateParsing");
      return DateTime(1970);
    }
  }

  /// Ex: "2024-10-20"
  DateTime get yearMonthDayFormat {
    try {
      return DateFormat("yyyy-MM-dd").parse(this);
    } catch (e) {
      printDM("Error: ${e.toString()}", name: "DateParsing");
      return DateTime(1970);
    }
  }
}

extension StringDateTime on DateTime {
  /// Ex: "2023-04-19 12:00:00"
  String toDateString() {
    try {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(this);
    } catch (e) {
      printDM("Error: $e", name: "StringDateTime");
      return "No Date Found";
    }
  }
}


extension DateTimeX on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'time_just_now'.toTr();
    }
    else if (difference.inMinutes < 60) {
      return _minutesAgo(difference.inMinutes);
    }
    else if (difference.inHours < 24) {
      return _hoursAgo(difference.inHours);
    }
    else if (difference.inDays == 1) {
      return 'time_yesterday'.toTr();
    }
    else if (difference.inDays < 7) {
      return _daysAgo(difference.inDays);
    }
    else {
      return _formattedDate();
    }
  }

  String _minutesAgo(int minutes) {
    return '$minutes ${'time_minutes'.toTr()}';
  }

  String _hoursAgo(int hours) {
    return '$hours ${'time_hours'.toTr()}';
  }

  String _daysAgo(int days) {
    return '$days ${'time_days'.toTr()}';
  }

  String _formattedDate() {
    return '$day/$month/$year';
  }
}



