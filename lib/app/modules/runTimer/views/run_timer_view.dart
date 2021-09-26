import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

import '../controllers/run_timer_controller.dart';

class RunTimerView extends GetView<RunTimerController> {
  CountDownController _controller = CountDownController();

  int _duration = int.parse(Get.parameters['time']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.pageBackgroundColor,
        title: Text("Timer is running".tr),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: CircularCountDownTimer(
                duration: _duration,
                initialDuration: 0,
                controller: _controller,
                width: Get.width / 2,
                height: Get.height / 2,
                ringColor: Colors.grey[300],
                ringGradient: null,
                fillColor: CustomColors.runTimerInside,
                fillGradient: null,
                backgroundColor: CustomColors.pageBackgroundColor,
                backgroundGradient: null,
                strokeWidth: 15.0,
                strokeCap: StrokeCap.butt,
                textStyle: TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.HH_MM_SS,
                isReverse: true,
                isReverseAnimation: true,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                },
                onComplete: () {
                  controller.isStart.value = false;
                },
              )),
          Obx(()=>RaisedButton(
                  color: CustomColors.pageBackgroundColor,
                  shape: const StadiumBorder(),
                  onPressed: (){
                    controller.isStart.value == true ?
                    _controller.pause() :
                    _controller.resume();
                    controller.changeStart();
                  },
                  child: controller.isStart.value == true ?
                  Icon(Icons.pause_circle_outline, color: CustomColors.minHandEndColor,size: 60.0,):
                  Icon(Icons.play_circle_outline, color: CustomColors.minHandEndColor,size: 60.0,)
              )
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
              ),
              Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.transit_enterexit),
                    label: Text("Exit".tr, style: TextStyle(color: Colors.white),),
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  )
              ),

              SizedBox(
                width: 20,
              ),
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text("ReStart".tr, style: TextStyle(color: Colors.white,),),
                  onPressed: () => _controller.restart(duration: _duration),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  )
                ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      )
    );
  }
}
