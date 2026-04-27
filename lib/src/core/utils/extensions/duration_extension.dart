import 'package:flutter/material.dart';

extension DurationExtension on int {
  Duration get toHours => Duration(hours: this);
  Duration get toMinutes => Duration(minutes: this);
  Duration get toSeconds => Duration(seconds: this);
  Duration get toMilliseconds => Duration(milliseconds: this);
  Duration get toMicroseconds => Duration(microseconds: this);


}
extension TimeFormat on int {
  String toTimeString({bool showHours = false}) {
    Duration duration = Duration(seconds: this);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
String timer = '';
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
if(showHours){
  timer = "$hours:$minutes:$seconds";
}else{
  timer = "$minutes:$seconds";
}
    return timer;
  }
}
extension DateTimeExtension on DateTime? {
  DateTime get noneNull => this ?? DateTime.now();

  TimeOfDay get toTimeOfDay =>
      TimeOfDay(hour: noneNull.hour, minute: noneNull.minute);

  String get toTime => '${noneNull.hour}:${noneNull.minute}';
}
