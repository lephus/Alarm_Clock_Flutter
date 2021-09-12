import 'dart:math';
import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import '../controllers/alarm_controller.dart';
class AlarmView extends GetView<AlarmController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Alarm',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w600
                ),
              ),
              Obx(()=>Expanded(
                  child: controller.isDataProcessingSpec.value == true ?  Center(
                    child: Text('Loading...', style: TextStyle(color: Colors.white, ),),
                  ) : ListView(
                            children: controller.alarms.map<Widget>((alarm){
                            return Container(
                                margin: EdgeInsets.only(bottom: 28.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                  colors:  GradientColors().GetGradientColors(alarm.gradientColorIndex),
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: GradientColors().GetGradientColors(alarm.gradientColorIndex).last.withOpacity(0.4),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                      offset: Offset(4,4)
                                    )
                                  ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.label_important_outline, color: Colors.greenAccent,size: 18.0,),
                                          SizedBox(width: 6.0,),
                                          Text(alarm.title, style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 18.0),),
                                        ],
                                      ),
                                      Switch(
                                      value: alarm.isPending == 1 ? false : true,
                                      onChanged: (bool value){
                                        controller.activeOrUnActiveAlarm(alarm);
                                      },
                                      activeColor: Colors.white,
                                    )
                                    ],
                                  ),
                                    Text(
                                    'Create at: ${alarm.alarmDateTime.day}- ${alarm.alarmDateTime.month}- ${alarm.alarmDateTime.year}',
                                  style: TextStyle(color: Colors.white54, fontSize: 16.0, fontFamily: 'avenir',),
                                  ),
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.alarm, color: Colors.white,),
                                          SizedBox(width: 12.0,),
                                          Text(
                                            alarm.alarmDateTime.hour > 12 ? '${alarm.alarmDateTime.hour}:${alarm.alarmDateTime.minute} PM' : '${alarm.alarmDateTime.hour}:${alarm.alarmDateTime.minute} AM',
                                            style:TextStyle(color: Colors.white, fontSize: 30.0),
                                          )
                                        ]
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size:30.0,
                                          ),
                                        onPressed: (){
                                              controller.deleteAlarm(alarm.id);
                                        }
                                      ),
                                        ],
                                      )
                                    ],
                                  )
                                  ],
                                ),
                              );
                              }).followedBy([
                                    Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF444974) ,Color(0xFF444974)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                    ),
                                    child: DottedBorder(
                                      padding: EdgeInsets.all(20.0),
                                      color: Colors.transparent,
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(24),
                                      // ignore: deprecated_member_use
                                        child: FlatButton(
                                        onPressed: (){
                                          displayAddAlarm(context);
                                        },
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.add_to_photos_sharp, color: Colors.blueAccent, size: 34.0,),
                                          Text('Add Alarm',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'avenir',
                                            fontWeight: FontWeight.w600
                                          ),)
                                        ],
                                      ),
                                      ),
                                    ),
                                  )
                                  ]).toList(),
                        )
                )
              )
            ],
          ),
        )
    );
  }
  void displayAddAlarm(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: CustomColors.menuBackgroundColor,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Alarm',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: (){
                        // DatePicker.showDatePicker(context,
                        //     showTitleActions: true,
                        //     minTime: DateTime(DateTime.now().year, 1, 1),
                        //     maxTime: DateTime(5000, 1, 1),
                        //     theme: DatePickerTheme(
                        //         headerColor: CustomColors.dividerColor,
                        //         backgroundColor: Colors.white,
                        //         itemStyle: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 18),
                        //         doneStyle:
                        //         TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w800)),
                        //     onChanged: (date) {
                        //     }, onConfirm: (date) {
                        //       controller.formattedDate('$date');
                        //     }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.date_range_outlined, size:22,color: Colors.grey),
                              SizedBox(width: 10.0,),
                              Obx(()=>Text(
                                  controller.formattedDate.value.split(' ').first,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22,
                                      fontFamily: 'avenir',
                                      fontWeight: FontWeight.w600
                                  )
                              )),
                            ],
                          ),
                          Icon(Icons.check, size:26,color: Colors.grey)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'description...',
                        labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                        hintText: 'enter your description alarm...',
                        hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      controller: controller.titleTextEditingController,
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: (){
                          DatePicker.showTimePicker(context, showTitleActions: true,
                              onChanged: (date) {
                              }, onConfirm: (date) {
                                controller.settingTime(date);
                              }, currentTime: DateTime.now());
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.timer, size:22,color: Colors.blue),
                                  SizedBox(width: 10.0,),
                                  Obx(()=>Text(
                                      controller.formattedTime.value,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'avenir',
                                          fontWeight: FontWeight.w600
                                      )
                                  )),
                                ],
                              ),
                              Icon(Icons.edit_outlined, size:26,color: Colors.deepOrange)
                            ],
                          ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: CustomColors.clockBG,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () async{
                          var rnd = new Random();
                          var alarmInfo = AlarmInfo(
                            title: controller.titleTextEditingController.text == null ? '' : controller.titleTextEditingController.text,
                            alarmDateTime: DateTime.parse('${controller.formattedDate.value.split(' ').first} ${controller.formattedTime.value}'),
                            isPending: 0,
                            gradientColorIndex: 0 + rnd.nextInt(4 - 0)
                          );
                          controller.insertAlarmDatabase(alarmInfo);
                          controller.refreshListAlarm();
                          Get.back();
                        },
                        child: Text('Save',
                        style: TextStyle(
                            color: Colors.green[400],
                            fontSize: 22,
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w600
                          )
                        ),
                      )
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
