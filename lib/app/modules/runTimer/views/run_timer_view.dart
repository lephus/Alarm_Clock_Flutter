import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/run_timer_controller.dart';

class RunTimerView extends GetView<RunTimerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RunTimerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RunTimerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
