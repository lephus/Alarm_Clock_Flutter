import 'package:get/get.dart';

class TimerController extends GetxController {
  //TODO: Implement TimerController

  final isStart = false.obs;
  var endTime = 0.obs;
  var hour = 0.obs;
  var minute = 0.obs;
  var se = 0.obs;
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
  void changeIsStart() => isStart.value == true ? isStart.value = false : isStart.value = true;
}
