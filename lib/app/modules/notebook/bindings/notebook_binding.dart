import 'package:get/get.dart';

import '../controllers/notebook_controller.dart';

class NotebookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotebookController>(
      () => NotebookController(),
    );
  }
}
