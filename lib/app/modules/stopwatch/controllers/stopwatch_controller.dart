import 'package:get/get.dart';

class StopwatchController extends GetxController {
  //TODO: Implement StopwatchController

  final count = 0.obs;
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
  void increment() => count.value++;
}
