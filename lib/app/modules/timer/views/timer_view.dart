import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';

import '../controllers/timer_controller.dart';

class TimerView extends GetView<TimerController> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height/3,
                child: Row(
                  children: [
                    Expanded(
                        child: ListWheelScrollView(
                          children: [
                            Text("1", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("2", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("3", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("4", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("5", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("6", style: TextStyle(color:Colors.white, fontSize: 28),),
                            Text("7", style: TextStyle(color:Colors.white, fontSize: 28),),
                          ],
                          itemExtent: 35,
                          diameterRatio: 1,
                          offAxisFraction: -0.4
                        )
                    ),
                    Expanded(
                        child: ListWheelScrollView(
                            children: [
                              Text("1", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("2", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("3", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("4", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("5", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("6", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("7", style: TextStyle(color:Colors.white, fontSize: 28),),
                            ],
                            itemExtent: 35,
                            diameterRatio: 1,
                            offAxisFraction: -0.4
                        )
                    ),
                    Expanded(
                        child: ListWheelScrollView(
                            children: [
                              Text("1", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("2", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("3", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("4", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("5", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("6", style: TextStyle(color:Colors.white, fontSize: 28),),
                              Text("7", style: TextStyle(color:Colors.white, fontSize: 28),),
                            ],
                            itemExtent: 35,
                            diameterRatio: 1,
                            offAxisFraction: -0.4
                        )
                    ),
                  ],
                )
              )
            ],
          ),
        )
    );
  }
}
