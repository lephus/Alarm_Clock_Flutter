// ignore_for_file: must_be_immutable

import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
List<int> listTimer = [];
class TimerView extends GetView<TimerController> {
  @override
  Widget build(BuildContext context) {
    listTimer.clear();
    for(int i = 0; i<=60; i++){
      listTimer.add(i);
    }
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
                            itemExtent: 45,
                            magnification: 1.5,
                            useMagnifier: true,
                            perspective: 0.005,
                            onSelectedItemChanged: (value){
                              controller.setTimeHour(value);
                            },
                            children:  <Widget>[
                                ...listTimer.map((int number) {
                              return Text("${number}", style: TextStyle(color: Colors.white, fontSize: 20.0),);
                            })
                            ],
                        )
                    ),
                    Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 45,
                          magnification: 1.5,
                          useMagnifier: true,
                          perspective: 0.005,
                          onSelectedItemChanged: (value){
                            controller.setTimeMinute(value);
                          },
                          children:  <Widget>[
                            ...listTimer.map((int number) {
                              return Text("${number}", style: TextStyle(color: Colors.white, fontSize: 20.0),);
                            })
                          ],
                        )
                    ),
                    Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 45,
                          magnification: 1.5,
                          useMagnifier: true,
                          perspective: 0.005,
                          onSelectedItemChanged: (value){
                            controller.setTimeSecond(value);
                          },
                          children:  <Widget>[
                            ...listTimer.map((int number) {
                              return Text("${number}", style: TextStyle(color: Colors.white, fontSize: 20.0),);
                            })
                          ],
                        )
                    )
                  ],
                )
              ),
              Container(
                height: Get.height/5,
                  alignment: Alignment.center,
                  child: Obx(()=> Text('${controller.getTimeHour()}'+":"+"${controller.getTimeMinute()}"+":"+"${controller.getTimeSecond()}",
                  style: TextStyle(color: CustomColors.minHandEndColor, fontSize: 38.0, fontWeight: FontWeight.w800)),
                )
              ),
              SizedBox(
                height: 65.0,
                width: 65.0,
                child: IconButton(
                    onPressed: (){Get.toNamed("/run-timer?time=${controller.getSumTime()}");},
                    icon: Icon(Icons.play_circle_fill_outlined, color: CustomColors.minHandEndColor,size: 70.0,)
                )
              )
            ],
          ),
        )
    );
  }
}
