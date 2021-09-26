import 'dart:async';
import 'package:alarm_clock_flutter/app/data/language_controller.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/controllers/alarm_controller.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/views/alarm_view.dart';
import 'package:alarm_clock_flutter/app/modules/clock/views/clock_view.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/controllers/notebook_controller.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/views/notebook_view.dart';
import 'package:alarm_clock_flutter/app/modules/setting/controllers/setting_controller.dart';
import 'package:alarm_clock_flutter/app/modules/setting/views/setting_view.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/controllers/stopwatch_controller.dart';
import 'package:alarm_clock_flutter/app/modules/stopwatch/views/stopwatch_view.dart';
import 'package:alarm_clock_flutter/app/modules/timer/controllers/timer_controller.dart';
import 'package:alarm_clock_flutter/app/modules/timer/views/timer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  LanguageController languageController = Get.put(LanguageController());
  final controllerAlarm = Get.put(AlarmController());
  final controllerTimer = Get.put(TimerController());
  final controllerStopwatch = Get.put(StopwatchController());
  final controllerNotebook = Get.put(NotebookController());
  final controllerSetting = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      controller.setTime();
    });
    return  Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        body: Row(
          children: <Widget>[
            Obx(() =>
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // ignore: deprecated_member_use
                        buildMenuButton('Clock'.tr, 'clock_icon.png',0),
                        SizedBox(height: 20,),
                        buildMenuButton('Alarm'.tr, 'alarm_icon.png',1),
                        SizedBox(height: 20,),
                        buildMenuButton('Timer'.tr, 'timer_icon.png',2),
                        SizedBox(height: 20,),
                        buildMenuButton('Stopwatch'.tr, 'stopwatch_icon.png',3),
                        SizedBox(height: 20,),
                        buildMenuButton('Notebook'.tr, 'notebook.png',4),
                        SizedBox(height: 20,),
                        buildMenuButton('Setting'.tr, 'setting.png',5),
                      ],
                    )),
            ),
            // VerticalDivider(color: Colors.white70,width: 1,),
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
                    'Clock & Notebook'.tr,
                    style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 16),
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
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 45, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${controller.formattedDate.value}',
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100),
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
                          'Timezone'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                              style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 20),
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
      }
      if(controller.count.value == 3){
        return Expanded(child: StopwatchView());
      }
      if(controller.count.value == 4){
        return Expanded(child: NotebookView());
      }
      else{
        return Expanded(child: SettingView());
      }
    }
  }

  // ignore: deprecated_member_use
  Widget buildMenuButton(String title, String image, int index){
    // ignore: deprecated_member_use
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight:Radius.circular(20), )
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
        color: index == controller.count.value ? Color(0xFF444974) : Colors.transparent,
        onPressed: (){
          controller.setIndex(index);
        },
        child: Column(
          children: <Widget>[
            Image.asset('assets/'+image, scale: 2.5,),
            Text(
              title ?? '',style: TextStyle(fontFamily: 'avenir' , color: Colors.white, fontSize: 12),
            )
          ],
        )
    );
  }
}
