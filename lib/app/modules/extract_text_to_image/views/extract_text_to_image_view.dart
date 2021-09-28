import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/extract_text_to_image_controller.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
class ExtractTextToImageView extends GetView<ExtractTextToImageController> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: <Widget>[
          Obx(()=>
            controller.imageIsReady.value == false ?
            Container(
              height: Get.height / 3,
              color: Colors.grey,
              child: Icon(Icons.image, size: 50.0),
            ) :
            Container(
              height: Get.height / 3,
              // decoration: BoxDecoration(
              //   color: Colors.blue,
              //   image: DecorationImage(
              //       image: FileImage(controller.fileImage),
              //       fit: BoxFit.fill
              //   ),
              // )
            )
          ),
          Container(
            height: 40.0,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                'Pick iamge with text',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: ()async{
                controller.scanning.value = false;
                controller.fileImage = await _picker.pickImage(source: ImageSource.gallery);
                controller.extractText = await FlutterTesseractOcr.extractText(controller.fileImage.path);
                print('extractText ${controller.extractText}');
                controller.imageIsReady.value = true;
                controller.scanning.value = true;
              },
            ),
          ),
          SizedBox(height: 20.0,),
          Obx(()=>
          controller.scanning.value == false ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              Text(
                '${controller.extractText}',
              )
          )
        ],
      )
    );
  }
}
