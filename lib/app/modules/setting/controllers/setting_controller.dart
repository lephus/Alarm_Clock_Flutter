import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var isChangeLanguage = 1.obs;
  @override
  void onInit() {
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
  showSnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.grey[200],
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black);
  }
}
