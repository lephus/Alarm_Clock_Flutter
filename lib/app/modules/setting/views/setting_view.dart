import 'package:alarm_clock_flutter/app/data/language_controller.dart';
import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  LanguageController languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("App info".tr, style: TextStyle(color: CustomColors.minHandEndColor),),
            backgroundColor: CustomColors.pageBackgroundColor,
          ),
          backgroundColor: CustomColors.pageBackgroundColor,
          body: ListView(
            children: [
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.width/3,
                    width: Get.width/3,
                    child: Image.asset('assets/phu_logo.png', scale: 1.0),
                  ),
                  Text("version 1.0.1".tr, style: TextStyle(color: Colors.white60),)
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  SizedBox(width: 10.0,),
                  Expanded(
                      child: Obx(()=>
                      controller.isChangeLanguage.value == 1 ?
                      OutlinedButton.icon(
                        icon: Icon(Icons.circle),
                        label: Text("Vietnamese", style: TextStyle(color: Colors.white,),),
                        onPressed: ()async{
                          await languageController.changeLanguage('vn', 'VN');
                          controller.isChangeLanguage.value = 1;
                          await controller.controllerShowSnackBar("Select language Vietnamese".tr, "");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ) :
                      OutlinedButton.icon(
                        icon: Icon(Icons.circle_outlined),
                        label: Text("Vietnamese", style: TextStyle(color: Colors.white,),),
                        onPressed: ()async{
                          await languageController.changeLanguage('vn', 'VN');
                          controller.isChangeLanguage.value = 1;
                          await controller.controllerShowSnackBar("Select language Vietnamese".tr, "");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      )
                      )
                  ),
                  SizedBox(width: 10.0,),
                  Expanded(
                      child:Obx(()=>
                      controller.isChangeLanguage.value == 2 ?
                      OutlinedButton.icon(
                        icon: Icon(Icons.circle),
                        label: Text("English", style: TextStyle(
                          color: Colors.white,),),
                        onPressed: ()async{
                          await languageController.changeLanguage('es', 'US');
                          controller.isChangeLanguage.value = 2;
                          await controller.controllerShowSnackBar("Select language English", "");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ) :
                      OutlinedButton.icon(
                        icon: Icon(Icons.circle_outlined),
                        label: Text("English", style: TextStyle(color: Colors.white,),),
                        onPressed: ()async{
                          await languageController.changeLanguage('es', 'US');
                          controller.isChangeLanguage.value = 2;
                          await controller.controllerShowSnackBar("Select language English", "");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      )
                      )
                  ),
                  SizedBox(width: 10.0,),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                color: CustomColors.pageBackgroundColor,
                shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 1.0,
                    )),
                child: ListTile(
                  leading: Icon(Icons.local_fire_department ,size: 20.0, color: Colors.red,),
                  title: Text('Non-profit products'.tr, style: TextStyle( color: Colors.white, fontSize: 14)),
                  subtitle: Text('please make sure you want to buy me a coffee'.tr, style: TextStyle(color: Colors.white60, fontSize: 12)),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  ClipboardData data = ClipboardData(text: '0041000370790');
                  await Clipboard.setData(data);
                  controller.controllerShowSnackBar("Coppy success".tr, "0041000370790");
                },
                child: Card(
                  color: CustomColors.pageBackgroundColor,
                  shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 1.0,
                      )),
                  child: ListTile(
                    leading: Icon(Icons.auto_awesome ,size: 30.0, color: CustomColors.hourHandEndColor,),
                    title: Text('0041000370790', style: TextStyle(fontFamily: 'avenir' , color: Colors.white, fontSize: 14)),
                    subtitle: Text('Vietcombank - LE HUU PHU', style: TextStyle(fontFamily: 'avenir' , color: Colors.white60, fontSize: 12)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  ClipboardData data = ClipboardData(text: '0328814589');
                  await Clipboard.setData(data);
                  controller.controllerShowSnackBar("Coppy success".tr, "0328814589");
                },
                child: Card(
                  color: CustomColors.pageBackgroundColor,
                  shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 1.0,
                      )),
                  child: ListTile(
                    leading: Icon(Icons.animation ,size: 30.0, color: CustomColors.runTimerInside,),
                    title: Text('032 8814 589', style: TextStyle(fontFamily: 'avenir' , color: Colors.white, fontSize: 14)),
                    subtitle: Text('MoMo - LE HUU PHU', style: TextStyle(fontFamily: 'avenir' , color: Colors.white60, fontSize: 12)),
                  ),
                ),
              ),
              Card(
                color: CustomColors.pageBackgroundColor,
                shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 1.0,
                    )),
                child: ListTile(
                  leading: FlutterLogo(size: 30.0),
                  title: Text('phulealali@gmail.com', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: Text('Contact work'.tr, style: TextStyle( color: Colors.white60, fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
