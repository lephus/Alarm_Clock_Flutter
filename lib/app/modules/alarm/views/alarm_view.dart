import 'package:alarm_clock_flutter/app/data/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
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
              Expanded(
                  child: ListView(
                    children: alarms.map((alarm){
                      return Container(
                        margin: EdgeInsets.only(bottom: 28.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: alarm.gradientColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          boxShadow: [
                            BoxShadow(
                              color: alarm.gradientColor.last.withOpacity(0.4),
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
                                    Text(alarm.description, style: TextStyle(fontFamily: 'avenir', color: Colors.white, fontSize: 18.0),),
                                  ],
                                ),
                               Switch(
                                  value: true,
                                  onChanged: (bool value){
                                  },
                                 activeColor: Colors.white,
                                )
                              ],
                            ),
                            Text(
                              'mon - fir',
                              style: TextStyle(color: Colors.white54, fontSize: 16.0, fontFamily: 'avenir',),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '13:49 AM',
                                  style:TextStyle(color: Colors.white, fontSize: 30.0),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                  size:30.0,
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
                            child: FlatButton(
                                  onPressed: (){},
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
            ],
          ),
        )
    );
  }
}
