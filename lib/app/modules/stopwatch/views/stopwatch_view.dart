// ignore_for_file: deprecated_member_use

import 'package:alarm_clock_flutter/app/modules/stopwatch/views/count_up_timer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/stopwatch_controller.dart';

class StopwatchView extends GetView<StopwatchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountUpTimerPage(),
      )
    );
  }
}