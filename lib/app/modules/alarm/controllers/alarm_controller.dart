import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlarmController extends GetxController {
  //TODO: Implement AlarmController

  TextEditingController titleTextEditingController = new TextEditingController();

  var formattedTime = DateFormat('HH:mm').format(DateTime.now()).toString().obs;
  var formattedDate = DateFormat('yMMMd').format(DateTime.now()).toString().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void settingDate(var Date){
    formattedDate.value = DateFormat('yMMMd').format(DateTime.parse(Date)).toString();
  }
  void settingTime(var Time){
    formattedTime.value =  DateFormat('HH:mm').format(DateTime.parse(Time)).toString();
  }
}
