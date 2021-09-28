// import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ExtractTextToImageController extends GetxController {
  var scanning = false.obs;
  var extractText = '';
  XFile fileImage = null;
  var imageIsReady = false.obs;
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

  void getImageIsReady(){
    if(fileImage == null ){
      imageIsReady.value = false;
    }
    imageIsReady.value = true;
  }

}
