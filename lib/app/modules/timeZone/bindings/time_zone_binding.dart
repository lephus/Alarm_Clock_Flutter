import 'package:get/get.dart';

import '../controllers/time_zone_controller.dart';

class TimeZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeZoneController>(
      () => TimeZoneController(),
    );
  }
}
