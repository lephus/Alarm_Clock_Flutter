import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {

  final FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController();
  final isStart = false.obs;
  var endTime = 0.obs;
  var hour = 0.obs;
  var minute = 0.obs;
  var second = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    hour.value = 0;
    minute.value = 0;
    second.value = 0;
  }
  void changeIsStart() => isStart.value == true ? isStart.value = false : isStart.value = true;

  void setTimeHour(var v){
    hour.value = v;
  }
  void setTimeMinute(var v){
    minute.value = v;
  }
  void setTimeSecond(var v){
    second.value = v;
  }
}
