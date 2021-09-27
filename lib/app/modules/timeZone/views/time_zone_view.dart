import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/time_zone_controller.dart';

class TimeZoneView extends GetView<TimeZoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeZoneView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TimeZoneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
