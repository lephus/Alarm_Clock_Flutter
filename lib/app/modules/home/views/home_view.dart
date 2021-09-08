import 'dart:async';

import 'package:alarm_clock_flutter/app/modules/alarm/controllers/alarm_controller.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/views/alarm_view.dart';
import 'package:alarm_clock_flutter/app/modules/clock/views/clock_view.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/controllers/stopwatch_controller.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/views/stopwatch_view.dart';
import 'package:alarm_clock_flutter/app/modules/timer/controllers/timer_controller.dart';
import 'package:alarm_clock_flutter/app/modules/timer/views/timer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final controllerAlarm = Get.put(AlarmController());
  final controllerTimer = Get.put(TimerController());
  final controllerStopwatch = Get.put(StopwatchController());

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      controller.setTime();
    });
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Obx(() =>
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                buildMenuButton('Clock', 'clock_icon.png',0),
                SizedBox(height: 30,),
                buildMenuButton('Alarm', 'alarm_icon.png',1),
                SizedBox(height: 30,),
                buildMenuButton('Timer', 'timer_icon.png',2),
                SizedBox(height: 30,),
                buildMenuButton('Stopwatch', 'stopwatch_icon.png',3),
              ],
            )),
          VerticalDivider(color: Colors.white70,width: 1,),
          Obx(()=>ExpandScren())
        ],
      )
    );
  }
  Widget ExpandScren(){
    if(controller.count.value == 0 ){
      return Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Clock & Been love memory',
                    style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 24),
                  ),
                ),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              '${controller.formattedTime.value}',
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 54, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${controller.formattedDate.value}',
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 24, fontWeight: FontWeight.w100),
                            ),
                          ],
                        )
                    ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.loose,
                  child: ClockView(),
                ),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Timezone',
                          style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 22),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 28.0,
                              height: 28.0,
                              child: Image.asset('assets/utc.png'),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'UTC '+controller.offsetSign,
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 22),
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          )
      );
    }else{
      if(controller.count.value == 1){
        return Expanded(child: AlarmView());
      }
      if(controller.count.value == 2){
        return Expanded(child: TimerView());
      }else{
        return Expanded(child: StopwatchView());
      }
    }
  }

  // ignore: deprecated_member_use
  Widget buildMenuButton(String title, String image, int index){
    // ignore: deprecated_member_use
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(32), bottomRight:Radius.circular(32), )
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
        color: index == controller.count.value ? Color(0xFF444974) : Colors.transparent,
        onPressed: (){
          controller.setIndex(index);
        },
        child: Column(
          children: <Widget>[
            Image.asset('assets/'+image, scale: 1.5,),
            Text(
              title ?? '',style: TextStyle(fontFamily: 'avenir' , color: Colors.white, fontSize: 14),
            )
          ],
        )
    );
  }
}
