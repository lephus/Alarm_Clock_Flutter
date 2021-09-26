import 'package:alarm_clock_flutter/app/data/notebook_database.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/notebook_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotebookController extends GetxController {
  //TODO: Implement AlarmController

  TextEditingController titleTextEditingController = new TextEditingController();
  TextEditingController descriptionTextEditingController = new TextEditingController();

  NotebookDatabase _notebookDatabase = NotebookDatabase();
  var formattedTime = DateFormat('HH:mm').format(DateTime.now()).obs;
  var formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  List<NotebookInfo> notes = [];
  var isDataProcessingSpec = true.obs;
  var isNotification = false.obs;
  @override
  void onInit() {
    isDataProcessingSpec.value = true;
    _notebookDatabase.initializeDatabase().then((value){
      print('notebook database is ready');
      refreshListNotebook();
    });
    super.onInit();
  }

  @override
  void onReady() {
    refreshListNotebook();
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
  }
  void controllerShowSnackBar(String title, String message){
    showSnackBar(title, message);
  }
  @override
  void onClose() {}
  showSnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.grey[200],
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black);
  }

  void resetValue(){
    titleTextEditingController.text = "";
    descriptionTextEditingController.text = "";
    isNotification.value = false;
    formattedTime = DateFormat('HH:mm').format(DateTime.now()).obs;
    formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  }
  void refreshListNotebook() async{
    titleTextEditingController.clear();
    descriptionTextEditingController.clear();
    isDataProcessingSpec.value = true;
    _notebookDatabase.getNotebooks().then((value){
      notes = value;
      notes = notes.reversed.toList();
      isDataProcessingSpec.value = false;
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  void insertNotebookDatabase(NotebookInfo note){
     _notebookDatabase.insertNotebook(note);
  }
  void settingDate(var Date){
    formattedDate.value = DateFormat("yyyy-MM-dd").format(Date);
  }
  void settingTime(var Time){
    formattedTime.value =  DateFormat('HH:mm').format(Time);
  }
  void deleteNotebook(int id) async{
    isDataProcessingSpec.value = true;
    _notebookDatabase.deleteNotebook(id).then((value){
      isDataProcessingSpec.value = false;
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  void activeOrUnActiveNotebook(NotebookInfo notebookInfo)async{
    isDataProcessingSpec.value = true;
    _notebookDatabase.activeOrUnActiveNotebook(notebookInfo).then((value){
      isDataProcessingSpec.value = false;
    }).onError((error, stackTrace){
      isDataProcessingSpec.value = false;
    });
  }
  void updateNotebook(var title, var des, var _isPending){
    titleTextEditingController.text = title;
    descriptionTextEditingController.text = des;
    _isPending == 0 ? isNotification.value = true : isNotification.value = false;
  }

  void updateDatabaseNotebook(NotebookInfo notebookInfo)async{
    _notebookDatabase.updateNotebook(notebookInfo);
  }
}
