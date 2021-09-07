import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: 'learning flutter', gradientColor: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)), description: 'learning nodejs', gradientColor: GradientColors.sea),
];