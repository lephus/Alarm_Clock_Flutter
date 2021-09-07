import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  var formattedDate = DateFormat('EEE, d MMM').format(DateTime.now());
  var timezoneString = DateTime.now().timeZoneOffset.toString().split('.').first;
  var offsetSign = '';
  final count = 0.obs;
  @override
  void onInit() {
    var offsetSign = ''+timezoneString;
    if(!timezoneString.startsWith('-')) offsetSign = '+'+timezoneString;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void setIndex(value) => count.value = value;
}
