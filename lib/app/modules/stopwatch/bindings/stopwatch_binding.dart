import 'package:get/get.dart';

import '../controllers/stopwatch_controller.dart';

class StopwatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StopwatchController>(
      () => StopwatchController(),
    );
  }
}
