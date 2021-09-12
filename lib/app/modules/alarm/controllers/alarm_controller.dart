import 'package:alarm_clock_flutter/app/data/alarm_database.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlarmController extends GetxController {
  //TODO: Implement AlarmController

  TextEditingController titleTextEditingController = new TextEditingController();

  AlarmDatabase _alarmDatabase = AlarmDatabase();
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
      print('get list alarm is successfully');
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
      print('get list alarm is Error: $error');
    });
  }
  void insertAlarmDatabase(var alarm){
    _alarmDatabase.insertAlarm(alarm);
    print('insert Alarm successfully');
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
}
