import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stopwatch_controller.dart';

class StopwatchView extends GetView<StopwatchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StopwatchView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StopwatchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
