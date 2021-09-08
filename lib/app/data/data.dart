import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(isPending: true, alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'learning flutter', gradientColorIndex:0),
  AlarmInfo(isPending: false, alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'learning nodejs', gradientColorIndex: 4),
];