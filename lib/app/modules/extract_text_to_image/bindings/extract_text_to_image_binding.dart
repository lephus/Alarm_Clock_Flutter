import 'package:get/get.dart';

import '../controllers/extract_text_to_image_controller.dart';

class ExtractTextToImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtractTextToImageController>(
      () => ExtractTextToImageController(),
    );
  }
}
