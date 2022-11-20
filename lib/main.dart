import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/data/language.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('phu_logo');
  var InitializationSettingsIOS     = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: ( int id, String title, String body, String payload) async {}
    );
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,iOS: InitializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async{
        if  (payload != null) {
          debugPrint('notification payload: '+ payload);
        }
      }
  );
  // This will works always for lock screen Orientation.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        translations: Language(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', "US"),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  });
}
