import 'package:get/get.dart';
import 'package:intl/intl.dart';
class HomeController extends GetxController {
  //TODO: Implement HomeController
  var formattedTime = DateFormat('HH:mm:ss').format(DateTime.now()).toString().obs;
  var formattedDate = DateFormat('yMMMMd').format(DateTime.now()).toString().obs;
  var timezoneString = DateTime.now().timeZoneOffset.toString().split('.').first;
  var offsetSign = '';
  final count = 0.obs;
  @override
  void onInit() {
    offsetSign = ''+timezoneString;
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
  void setTime(){
    formattedTime.value = DateFormat('HH:mm:ss').format(DateTime.now()).toString();
    formattedDate.value = DateFormat('EEE, d MMM').format(DateTime.now()).toString();
  }
}
