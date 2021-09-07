import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timer_controller.dart';

class TimerView extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TimerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
