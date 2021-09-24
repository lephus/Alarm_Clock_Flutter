import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(isPending: 0, alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'learning flutter'),
  AlarmInfo(isPending: 1, alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'learning nodejs'),
];