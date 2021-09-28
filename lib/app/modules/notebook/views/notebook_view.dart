import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:alarm_clock_flutter/app/modules/notebook/notebook_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import '../controllers/notebook_controller.dart';

class NotebookView extends GetView<NotebookController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Notebook'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                ),
              ),
              Obx(()=>Expanded(
                  child: controller.isDataProcessingSpec.value == true ?  Center(
                    child: Center(child: Text("Loading...".tr, style: TextStyle(color:Colors.white),),),
                  ) : ListView(
                    children: controller.notes.map<Widget>((note){
                      return Container(
                        margin: EdgeInsets.only(bottom: 28.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            gradient: LinearGradient(
                                colors: [Color(0xFF444974) ,Color(0xFF444974)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
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
                                    Icon(Icons.notifications_active_outlined, color: Colors.yellow,size: 12.0,),
                                    SizedBox(width: 6.0,),
                                    Container(
                                      child: Text(
                                        '${note.alarmDateTime.day}- ${note.alarmDateTime.month}- ${note.alarmDateTime.year} ${note.alarmDateTime.hour}:${note.alarmDateTime.minute}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle( color: Colors.white60, fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: note.isPending == 1 ? false : true,
                                  onChanged: (bool value)async{
                                    await controller.activeOrUnActiveNotebook(note);
                                    await controller.refreshListNotebook();
                                  },
                                  activeColor: Colors.white,
                                )
                              ],
                            ),
                            Text(
                              '${note.description}',
                              style: TextStyle(color: Colors.white, fontSize: 16.0,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.event_note, color: Colors.greenAccent,size: 14.0,),
                                    SizedBox(width: 6.0,),
                                    Container(
                                      width: Get.width/3,
                                      child: Text(
                                        note.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                        alignment: Alignment.center,
                                        padding: new EdgeInsets.all(0.0),
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.green,
                                        ),
                                        onPressed: () async{
                                          controller.settingTime(note.alarmDateTime);
                                          controller.settingDate(note.alarmDateTime);
                                          await controller.updateNotebook(note.title, note.description, note.isPending);
                                          displayUpdateNotebook(context, note.id);
                                        }
                                    ),
                                    IconButton(
                                        alignment: Alignment.center,
                                        padding: new EdgeInsets.all(0.0),
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.redAccent
                                        ),
                                        onPressed: ()async{
                                          await controller.deleteNotebook(note.id);
                                          await controller.refreshListNotebook();
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
                              await controller.resetValue();
                              displayAddNotebook(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add_to_photos_sharp, color: Colors.blueAccent, size: 34.0,),
                                Text('Add Notebook'.tr,
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
  void displayAddNotebook(BuildContext context) {
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
                        'Add Notebook'.tr,
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    TextField(
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'titleNote...'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your title notebook...'.tr,
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      controller: controller.titleTextEditingController,
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'description...'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your description notebook...',
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      controller: controller.descriptionTextEditingController,
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Notification",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 14,
                            )
                        ),
                        Obx(()=>Switch(
                          value: controller.isNotification.value,
                          onChanged: (bool value){
                            controller.isNotification.value == true ? controller.isNotification.value = false : controller.isNotification.value = true;
                          },
                          activeColor: Colors.white,
                        ))
                      ],
                    ),
                    Obx(()=>
                    controller.isNotification.value == false ?
                        SizedBox(
                          height: 10,
                        ) :
                        Column(
                          children: [
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: (){
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(DateTime.now().year, 1, 1),
                                    maxTime: DateTime(5000, 1, 1),
                                    theme: DatePickerTheme(
                                        headerColor: CustomColors.dividerColor,
                                        backgroundColor: Colors.white,
                                        itemStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        doneStyle:
                                        TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w800)),
                                    onChanged: (date) {
                                    }, onConfirm: (date) {
                                      controller.formattedDate('$date');
                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.date_range_outlined, size:22,color: Colors.blueAccent),
                                      SizedBox(width: 10.0,),
                                      Obx(()=>Text(
                                          controller.formattedDate.value.split(' ').first,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )),
                                    ],
                                  ),
                                  Icon(Icons.edit_outlined, size:18,color: CustomColors.minHandStatColor)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )),
                                    ],
                                  ),
                                  Icon(Icons.edit_outlined, size:18,color: CustomColors.minHandStatColor)
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    // ignore: deprecated_member_use
                    OutlinedButton.icon(
                          icon: Icon(Icons.refresh),
                          label: Text("Text to image", style: TextStyle(color: Colors.white,),),
                          onPressed: () => Get.toNamed('/extract-text-to-image'),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 1.0, color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
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
                            var t = DateTime.now();
                            var idNote =t.day.toString()+t.hour.toString()+t.minute.toString()+t.second.toString();
                            var notebookInfo = NotebookInfo(
                                id: int.parse(idNote),
                                title: controller.titleTextEditingController.text == null ? '' : controller.titleTextEditingController.text,
                                description: controller.descriptionTextEditingController.text,
                                alarmDateTime: DateTime.parse('${controller.formattedDate.value.split(' ').first} ${controller.formattedTime.value}'),
                                isPending: controller.isNotification.value == true ? 0 : 1
                            );
                            await controller.insertNotebookDatabase(notebookInfo);
                            await controller.refreshListNotebook();
                            Get.back();
                          },
                          child: Text('Save'.tr,
                              style: TextStyle(
                                  color: Colors.green[400],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        )
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
  void displayUpdateNotebook(BuildContext context, int idNote) {
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
                        'Update Notebook'.tr,
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(height: 10.0,),
                    // ignore: deprecated_member_use
                    TextField(
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'title...'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your title notebook...'.tr,
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      controller: controller.titleTextEditingController,
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: CustomColors.menuBackgroundColor,
                        filled: true,
                        labelText: 'description...'.tr,
                        labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        hintText: 'enter your description notebook...',
                        hintStyle: TextStyle(fontSize: 14.0, color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                      controller: controller.descriptionTextEditingController,
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            "Notification".tr,
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 14,
                            )
                        ),
                        Obx(()=>Switch(
                          value: controller.isNotification.value,
                          onChanged: (bool value){
                            controller.isNotification.value == true ? controller.isNotification.value = false : controller.isNotification.value = true;
                          },
                          activeColor: Colors.white,
                        ))
                      ],
                    ),
                    // ignore: deprecated_member_use
                    Obx(()=>
                    controller.isNotification.value == false ?
                    SizedBox(
                      height: 10,
                    ) :
                    Column(
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: (){
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(DateTime.now().year, 1, 1),
                                maxTime: DateTime(5000, 1, 1),
                                theme: DatePickerTheme(
                                    headerColor: CustomColors.dividerColor,
                                    backgroundColor: Colors.white,
                                    itemStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    doneStyle:
                                    TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w800)),
                                onChanged: (date) {
                                }, onConfirm: (date) {
                                  controller.formattedDate('$date');
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.date_range_outlined, size:22,color: Colors.blueAccent),
                                  SizedBox(width: 10.0,),
                                  Obx(()=>Text(
                                      controller.formattedDate.value.split(' ').first,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      )
                                  )),
                                ],
                              ),
                              Icon(Icons.edit_outlined, size:16,color: CustomColors.minHandStatColor)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
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
                                  Icon(Icons.timer, size:16,color: Colors.blue),
                                  SizedBox(width: 10.0,),
                                  Obx(()=>Text(
                                      controller.formattedTime.value,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      )
                                  )),
                                ],
                              ),
                              Icon(Icons.edit_outlined, size:16,color: CustomColors.minHandStatColor)
                            ],
                          ),
                        ),
                      ],
                    )
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
                            var notebookInfo = NotebookInfo(
                                id: idNote,
                                title: controller.titleTextEditingController.text == null ? '' : controller.titleTextEditingController.text,
                                description: controller.descriptionTextEditingController.text,
                                alarmDateTime: DateTime.parse('${controller.formattedDate.value.split(' ').first} ${controller.formattedTime.value}'),
                                isPending: controller.isNotification.value == true ? 0 : 1
                            );
                            await controller.updateDatabaseNotebook(notebookInfo);
                            await controller.refreshListNotebook();
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
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
