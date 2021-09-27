// import 'package:alarm_clock_flutter/app/data/notebook_database.dart';
// import 'package:alarm_clock_flutter/app/modules/timeZone/local_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {

  // NotebookDatabase _localDatabase = NotebookDatabase();
  // List<LocalDataInfo> localDataInfos = [];
  var isChangeLanguage = 2.obs;
  @override
  void onInit() {
    // _localDatabase.getLocalData().then((value){
    //   localDataInfos = value;
    //   print('localDataInfos[0].codeNumber ${localDataInfos[0].codeNumber}');
    //   isChangeLanguage.value = localDataInfos[0].codeNumber;
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  void controllerShowSnackBar(String title, String message){
    showSnackBar(title, message);
  }
  @override
  void onClose() {}

  // void SettingLanguage(int id, String title){
  //   isChangeLanguage.value = id;
  //   _localDatabase.updateLanguage(id).then((value) => {
  //     showSnackBar(title, "")
  //   }).onError((error, stackTrace) => showSnackBar("Error", "Cannot update language"));
  // }
  
  showSnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.grey[200],
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black);
  }
}
