import 'package:flutter/material.dart';

extension DurationExtension on int {
  Duration get toHours => Duration(hours: this);
  Duration get toMinutes => Duration(minutes: this);
  Duration get toSeconds => Duration(seconds: this);
  Duration get toMilliseconds => Duration(milliseconds: this);
  Duration get toMicroseconds => Duration(microseconds: this);
}

extension DateTimeExtension on DateTime? {
  DateTime get notNull => this ?? DateTime.now();

  TimeOfDay get toTimeOfDay =>
      TimeOfDay(hour: notNull.hour, minute: notNull.minute);

  String get toTime => '${notNull.hour}:${notNull.minute}';
}

extension TimeStringFormatter on String {
  String toFormattedTime({bool isMinutes = false}) {
    final raw = int.tryParse(this) ?? 0;
    final totalSeconds = isMinutes ? raw * 60 : raw;

    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    } else if (minutes > 0) {
      return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    } else {
      return '00:${_twoDigits(seconds)}';
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}

extension SecondsToMinSec on int {
  /// Formats seconds as "-MM : SS Min"
  String toMinSecLabel({
    String sep = ' : ',
    String suffix = ' Min',
  }) {
    final isNeg = this < 0;
    final total = abs();
    final minutes = total ~/ 60;
    final seconds = total % 60;

    // Pad to at least 2 digits (but allow 3+ if minutes >= 100)
    final minStr =
        minutes < 100 ? minutes.toString().padLeft(2, '0') : minutes.toString();
    final secStr = seconds.toString().padLeft(2, '0');

    final sign = isNeg ? '-' : '';
    return '$sign$minStr$sep$secStr$suffix';
  }
}
