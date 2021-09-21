import 'package:get/get.dart';

class RunTimerController extends GetxController {
  //TODO: Implement RunTimerController
  final isStart = true.obs;
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
  void changeStart() => isStart.value == false ? isStart.value = true : isStart.value = false;
}
