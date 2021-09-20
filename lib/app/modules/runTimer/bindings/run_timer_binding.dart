import 'package:get/get.dart';

import '../controllers/run_timer_controller.dart';

class RunTimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunTimerController>(
      () => RunTimerController(),
    );
  }
}
