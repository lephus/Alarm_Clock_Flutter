import 'package:get/get.dart';

import 'package:alarm_clock_flutter/app/modules/alarm/bindings/alarm_binding.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/views/alarm_view.dart';
import 'package:alarm_clock_flutter/app/modules/clock/bindings/clock_binding.dart';
import 'package:alarm_clock_flutter/app/modules/clock/views/clock_view.dart';
import 'package:alarm_clock_flutter/app/modules/extract_text_to_image/bindings/extract_text_to_image_binding.dart';
import 'package:alarm_clock_flutter/app/modules/extract_text_to_image/views/extract_text_to_image_view.dart';
import 'package:alarm_clock_flutter/app/modules/home/bindings/home_binding.dart';
import 'package:alarm_clock_flutter/app/modules/home/views/home_view.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/bindings/notebook_binding.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/views/notebook_view.dart';
import 'package:alarm_clock_flutter/app/modules/runTimer/bindings/run_timer_binding.dart';
import 'package:alarm_clock_flutter/app/modules/runTimer/views/run_timer_view.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/bindings/stopwatch_binding.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/views/stopwatch_view.dart';
import 'package:alarm_clock_flutter/app/modules/timeZone/bindings/time_zone_binding.dart';
import 'package:alarm_clock_flutter/app/modules/timeZone/views/time_zone_view.dart';
import 'package:alarm_clock_flutter/app/modules/timer/bindings/timer_binding.dart';
import 'package:alarm_clock_flutter/app/modules/timer/views/timer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CLOCK,
      page: () => ClockView(),
      binding: ClockBinding(),
    ),
    GetPage(
      name: _Paths.ALARM,
      page: () => AlarmView(),
      binding: AlarmBinding(),
    ),
    GetPage(
      name: _Paths.TIMER,
      page: () => TimerView(),
      binding: TimerBinding(),
    ),
    GetPage(
      name: _Paths.STOPWATCH,
      page: () => StopwatchView(),
      binding: StopwatchBinding(),
    ),
    GetPage(
      name: _Paths.RUN_TIMER,
      page: () => RunTimerView(),
      binding: RunTimerBinding(),
    ),
    GetPage(
      name: _Paths.NOTEBOOK,
      page: () => NotebookView(),
      binding: NotebookBinding(),
    ),
    GetPage(
      name: _Paths.TIME_ZONE,
      page: () => TimeZoneView(),
      binding: TimeZoneBinding(),
    ),
    GetPage(
      name: _Paths.EXTRACT_TEXT_TO_IMAGE,
      page: () => ExtractTextToImageView(),
      binding: ExtractTextToImageBinding(),
    ),
  ];
}
