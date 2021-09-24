import 'package:alarm_clock_flutter/app/data/alarm_database.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlarmController extends GetxController {
  //TODO: Implement AlarmController

  TextEditingController titleTextEditingController = new TextEditingController();

  AlarmDatabase _alarmDatabase = AlarmDatabase();
  var isMonDaySelect = false.obs;
  var isTuesDaySelect = false.obs;
  var isWedesDaySelect = false.obs;
  var isThursDaySelect = false.obs;
  var isFriDaySelect = false.obs;
  var isSaturDaySelect = false.obs;
  var isSunDaySelect = false.obs;
  var isRepeat = false.obs;
  var music = "alarm_ringtone.mp3";
  var formattedTime = DateFormat('HH:mm').format(DateTime.now()).obs;
  var formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  List<AlarmInfo> alarms = [];
  var isDataProcessingSpec = true.obs;
  @override
  void onInit() {
    isDataProcessingSpec.value = true;
   _alarmDatabase.initializeDatabase().then((value){
      print('alarm database is ready');
      refreshListAlarm();
    });
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTextEditingController.dispose();
  }

  @override
  void onReady() {
    refreshListAlarm();
    super.onReady();
  }

  @override
  void onClose() {}

  void refreshListAlarm() async{
    titleTextEditingController.clear();
    isDataProcessingSpec.value = true;
    _alarmDatabase.getAlarms().then((value){
      alarms = value;
      alarms = alarms.reversed.toList();
      isDataProcessingSpec.value = false;
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
      print('get list alarm is Error: $error');
    });
    isMonDaySelect.value = false;
    isTuesDaySelect.value = false;
    isWedesDaySelect.value = false;
    isThursDaySelect.value = false;
    isFriDaySelect.value = false;
    isSaturDaySelect.value = false;
    isSunDaySelect.value = false;
    isRepeat.value = false;
  }
  void insertAlarmDatabase(var alarm){
    _alarmDatabase.insertAlarm(alarm);
  }
  void settingDate(var Date){
    formattedDate.value = DateFormat("yyyy-MM-dd").format(Date);
  }
  void settingTime(var Time){
    formattedTime.value =  DateFormat('HH:mm').format(Time);
  }
  void deleteAlarm(int id) async{
    isDataProcessingSpec.value = true;
    _alarmDatabase.deleteAlarm(id).then((value){
      isDataProcessingSpec.value = false;
      refreshListAlarm();
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  void activeOrUnActiveAlarm(AlarmInfo alarmInfo)async{
    isDataProcessingSpec.value = true;
    _alarmDatabase.activeOrUnActiveAlarm(alarmInfo).then((value){
      isDataProcessingSpec.value = false;
      refreshListAlarm();
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  void updateAlarm(AlarmInfo alarmInfo)async{
    isDataProcessingSpec.value = true;
    _alarmDatabase.updateAlarm(alarmInfo).then((value){
      print('phu: ${value}');
      isDataProcessingSpec.value = false;
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  String getDatTime(){
    String res = "";
    isMonDaySelect.value == true ? res += "2," : res +="";
    isTuesDaySelect.value == true ? res += "3," : res +="";
    isWedesDaySelect.value == true ? res += "4," : res +="";
    isThursDaySelect.value == true ? res += "5," : res +="";
    isFriDaySelect.value == true ? res += "6," : res +="";
    isSaturDaySelect.value == true ? res += "7," : res +="";
    isSunDaySelect.value == true ? res += "8," : res +="";
    return res;
  }
  String getDayRepeat(String s){
    var tmp = s.split(",");
    String res = "";
    for(int i = 0; i< tmp.length; i++) {
      if (tmp[i] == "") {
        continue;
      }
      if (tmp[i] == "8") {
        if(i == 0){
          res += " CN";
        }else{
          res += ", CN";
        }
      } else {
        if(i==0){
          res += " Th" + tmp[i];
        }else{
          res += ", Th" + tmp[i];
        }
      }
    }
    if(res == ""){
      return "No repeat";
    }
    return res;
  }
  void updateInformationAlarm(AlarmInfo alarmInfo){
    titleTextEditingController.text = alarmInfo.title;
    alarmInfo.isPending == 0 ? isRepeat.value = true : isRepeat.value = false;
    var tmp = alarmInfo.dayTime.split(",");
    isMonDaySelect.value = false;
    isTuesDaySelect.value = false;
    isWedesDaySelect.value = false;
    isThursDaySelect.value = false;
    isFriDaySelect.value = false;
    isSaturDaySelect.value = false;
    isSunDaySelect.value = false;
    tmp.length > 1 ? isRepeat.value = true : isRepeat.value = false;
    for(int i = 0; i< tmp.length; i++) {
      tmp[i] == "2" ? isMonDaySelect.value = true : null;
      tmp[i] == "3" ? isTuesDaySelect.value = true: null;
      tmp[i] == "4" ? isWedesDaySelect.value = true: null;
      tmp[i] == "5" ? isThursDaySelect.value = true: null;
      tmp[i] == "6" ? isFriDaySelect.value = true: null;
      tmp[i] == "7" ? isSaturDaySelect.value = true: null;
      tmp[i] == "8" ? isSunDaySelect.value = true: null;
    }
  }
}
