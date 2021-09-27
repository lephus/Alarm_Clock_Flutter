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
                'Alarm'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              ),
              Obx(()=>Expanded(
                  child: controller.isDataProcessingSpec.value == true ?  Center(
                    child: Center(child: Text("Loading...".tr, style: TextStyle(color:Colors.white),),),
                  ) : ListView(
                            addAutomaticKeepAlives: false,
                            cacheExtent: 100.0,
                            children: controller.alarms.map<Widget>((alarm){
                            return Container(
                                margin: EdgeInsets.only(bottom: 28.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                    border: Border.all(color: CustomColors.minHandStatColor)
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
                                          Container(
                                            width: 150,
                                            child: Text(
                                              alarm.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            ),
                                          )
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
                                    '${controller.getDayRepeat(alarm.dayTime)}',
                                  style: TextStyle(color: Colors.white, fontSize: 16.0,),
                                  ),
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.alarm, color: Colors.blue,size: 18.0,),
                                          SizedBox(width: 12.0,),
                                          Text(
                                            alarm.alarmDateTime.hour > 12 ? '${alarm.alarmDateTime.hour}:${alarm.alarmDateTime.minute} PM' : '${alarm.alarmDateTime.hour}:${alarm.alarmDateTime.minute} AM',
                                            style:TextStyle(color: Colors.white, fontSize: 20.0),
                                          )
                                        ]
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                                Icons.delete_forever,
                                                color: Colors.pinkAccent,
                                                size:20.0,
                                              ),
                                            onPressed: (){
                                                  controller.deleteAlarm(alarm.id);
                                            }
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down_circle_outlined,
                                                color: Colors.greenAccent,
                                                size:20.0,
                                              ),
                                              onPressed: ()async{
                                                await controller.updateInformationAlarm(alarm);
                                                displayUpdateAlarm(context, alarm);
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
                                        onPressed: ()async{
                                          await controller.refreshListAlarm();
                                          displayAddAlarm(context);
                                        },
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.add_to_photos_sharp, color: Colors.blueAccent, size: 34.0,),
                                          Text('Add Alarm'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
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
                      'Add Alarm'.tr,
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    TextField(
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'title'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your title alarm...'.tr,
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
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
                                  Icon(Icons.timer, size:18,color: Colors.blue),
                                  SizedBox(width: 10.0,),
                                  Obx(()=>Text(
                                      controller.formattedTime.value,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      )
                                  )),
                                ],
                              ),
                              Icon(Icons.edit_outlined, size:22,color: Colors.deepOrange)
                            ],
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.repeat,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            SizedBox(width: 12.0,),
                            Text(
                                "Repeat".tr,
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 14,
                                )
                            ),
                          ],
                        ),
                        Obx(()=>
                            Switch(
                              value: controller.isRepeat.value,
                              onChanged: (bool value){
                                controller.isRepeat.value == true ? controller.isRepeat.value = false : controller.isRepeat.value = true;
                              },
                              activeColor: Colors.white,
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Obx(()=>
                        controller.isRepeat.value == false ? SizedBox() :
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isMonDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isMonDaySelect.value == true ? controller.isMonDaySelect.value = false : controller.isMonDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Mo".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isTuesDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isTuesDaySelect.value == true ? controller.isTuesDaySelect.value = false : controller.isTuesDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Tu".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isWedesDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isWedesDaySelect.value == true ? controller.isWedesDaySelect.value = false : controller.isWedesDaySelect.value = true ;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "We".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isThursDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isThursDaySelect.value == true ? controller.isThursDaySelect.value = false : controller.isThursDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Th".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isFriDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isFriDaySelect.value == true ? controller.isFriDaySelect.value = false : controller.isFriDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Fr".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isSaturDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isSaturDaySelect.value == true ? controller.isSaturDaySelect.value = false : controller.isSaturDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Sa".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        checkColor: CustomColors.runTimerInside,
                                        value: controller.isSunDaySelect.value,
                                        onChanged: (bool value){
                                          controller.isSunDaySelect.value == true ? controller.isSunDaySelect.value = false : controller.isSunDaySelect.value = true;
                                        },
                                      )
                                  ),
                                  Expanded(
                                      child: Text(
                                        "Su".tr,
                                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          icon: Icon(Icons.queue_music),
                          label: Text("Select music".tr, style: TextStyle(color: Colors.white),),
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 0.0, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          alignment: Alignment.centerRight,
                          width: Get.width/2,
                          child: Text(
                            "Using define music",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        )

                      ],
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
                          var t = DateTime.now();
                          var idAlarm =t.day.toString()+t.hour.toString()+t.minute.toString()+t.second.toString();
                          var alarmInfo = AlarmInfo(
                            id: int.parse(idAlarm),
                            title: controller.titleTextEditingController.text == null ? '' : controller.titleTextEditingController.text,
                            alarmDateTime: DateTime.parse('${controller.formattedDate.value.split(' ').first} ${controller.formattedTime.value}'),
                            isPending: 0,
                            dayTime: controller.getDatTime(),
                            music: controller.music
                          );
                          await controller.insertAlarmDatabase(alarmInfo);
                          await controller.refreshListAlarm();
                          Get.back();
                        },
                        child: Text('Save'.tr,
                        style: TextStyle(
                            color: Colors.green[400],
                            fontSize: 18,
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
  void displayUpdateAlarm(BuildContext context, AlarmInfo alarm) {
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
                        'Update Alarm'.tr,
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    TextField(
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'title'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your title alarm...'.tr,
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
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
                              Icon(Icons.timer, size:20,color: Colors.blue),
                              SizedBox(width: 10.0,),
                              Obx(()=>Text(
                                  controller.formattedTime.value,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  )
                              )),
                            ],
                          ),
                          Icon(Icons.edit_outlined, size:20,color: Colors.deepOrange)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.repeat,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(width: 12.0,),
                            Text(
                                "Repeat".tr,
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                )
                            ),
                          ],
                        ),
                        Obx(()=>
                            Switch(
                              value: controller.isRepeat.value,
                              onChanged: (bool value){
                                controller.isRepeat.value == true ? controller.isRepeat.value = false : controller.isRepeat.value = true;
                              },
                              activeColor: Colors.white,
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Obx(()=>
                     controller.isRepeat.value == false ? SizedBox() :
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isMonDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isMonDaySelect.value == true ? controller.isMonDaySelect.value = false : controller.isMonDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Mo".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isTuesDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isTuesDaySelect.value == true ? controller.isTuesDaySelect.value = false : controller.isTuesDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Tu".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isWedesDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isWedesDaySelect.value == true ? controller.isWedesDaySelect.value = false : controller.isWedesDaySelect.value = true ;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "We".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isThursDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isThursDaySelect.value == true ? controller.isThursDaySelect.value = false : controller.isThursDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Th".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isFriDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isFriDaySelect.value == true ? controller.isFriDaySelect.value = false : controller.isFriDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Fr".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isSaturDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isSaturDaySelect.value == true ? controller.isSaturDaySelect.value = false : controller.isSaturDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Sa".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    checkColor: CustomColors.runTimerInside,
                                    value: controller.isSunDaySelect.value,
                                    onChanged: (bool value){
                                      controller.isSunDaySelect.value == true ? controller.isSunDaySelect.value = false : controller.isSunDaySelect.value = true;
                                    },
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    "Su".tr,
                                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          icon: Icon(Icons.queue_music),
                          label: Text("Select music".tr, style: TextStyle(color: Colors.white),),
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 0.0, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          alignment: Alignment.centerRight,
                          width: Get.width/2,
                          child: Text(
                            "Using define music",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        )
                      ],
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
                           var alarmInfo = AlarmInfo(
                                id: alarm.id,
                                title: controller.titleTextEditingController.text == null ? '' : controller.titleTextEditingController.text,
                                alarmDateTime: DateTime.parse('${controller.formattedDate.value.split(' ').first} ${controller.formattedTime.value}'),
                                isPending: alarm.isPending,
                                dayTime: controller.getDatTime(),
                                music: controller.music
                            );
                            await controller.updateAlarm(alarmInfo);
                            await controller.refreshListAlarm();
                            Get.back();
                          },
                          child: Text('Update'.tr,
                              style: TextStyle(
                                  color: Colors.green[400],
                                  fontSize: 16,
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
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blueAccent;
    }
    return Colors.greenAccent;
  }
}
