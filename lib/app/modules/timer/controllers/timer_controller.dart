import 'package:get/get.dart';

class TimerController extends GetxController {
  var endTime = 0.obs;
  var hour = 0.obs;
  var minute = 0.obs;
  var second = 0.obs;
  @override
  void onInit() {
    hour.value = 0;
    minute.value = 0;
    second.value = 0;
    super.onInit();
  }

  @override
  void onReady() {
    hour.value = 0;
    minute.value = 0;
    second.value = 0;
    super.onReady();
  }

  @override
  void onClose() {
    hour.value = 0;
    minute.value = 0;
    second.value = 0;
  }
  void setTimeHour(var v){
    hour.value = v;
  }
  void setTimeMinute(var v){
    minute.value = v;
  }
  void setTimeSecond(var v){
    second.value = v;
  }
  String getTimeHour(){
    if (hour.value < 10){
      return "0${hour.value}";
    }
    return "${hour.value}";
  }
  String getTimeMinute(){
    if (minute.value < 10){
      return "0${minute.value}";
    }
    return "${minute.value}";
  }
  String getTimeSecond(){
    if (second.value < 10){
      return "0${second.value}";
    }
    return "${second.value}";
  }
  int getSumTime(){
    return hour.value * 3600 + minute.value * 60 + second.value;
  }
}
