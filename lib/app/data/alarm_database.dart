import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';
import 'package:alarm_clock_flutter/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarmTable';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnDayTime = 'dayTime';
final String columnMusic = 'music';

class AlarmDatabase{
  static Database _database;
  static AlarmDatabase _alarmDatabase;

  AlarmDatabase._createInstance();
  factory AlarmDatabase(){
    if (_alarmDatabase == null){
      _alarmDatabase = AlarmDatabase._createInstance();
    }
    return _alarmDatabase;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';
    var database = openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $tableAlarm (
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnDayTime text not null,
          $columnMusic text not null
          )
          ''');
        }
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async{
    var db = await this.database;
    await db.insert(tableAlarm, alarmInfo.toMap());
    await scheduleAlarm(alarmInfo.alarmDateTime, alarmInfo.title, alarmInfo.dayTime, alarmInfo.music, alarmInfo.id);
  }

  Future<List<AlarmInfo>> getAlarms() async{
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }

  Future<int> deleteAlarm(int id) async{
    var db = await this.database;
    var res = await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
    await flutterLocalNotificationsPlugin.cancel(id);
    await flutterLocalNotificationsPlugin.cancel(id+2);
    await flutterLocalNotificationsPlugin.cancel(id+3);
    await flutterLocalNotificationsPlugin.cancel(id+4);
    await flutterLocalNotificationsPlugin.cancel(id+5);
    await flutterLocalNotificationsPlugin.cancel(id+6);
    await flutterLocalNotificationsPlugin.cancel(id+7);
    await flutterLocalNotificationsPlugin.cancel(id+8);
    return res;
  }

  Future<int> updateAlarm(AlarmInfo alarmInfo)async{
    var db = await this.database;
    var res = await db.rawUpdate('''
        UPDATE ${tableAlarm}
        SET
        ${columnTitle} = ?,
        ${columnDateTime} = ?,
        ${columnPending} = ?,
        ${columnDayTime} = ?,
        ${columnMusic} = ?
        WHERE ${columnId} = ?
        ''',[alarmInfo.title, alarmInfo.alarmDateTime.toString(), alarmInfo.isPending, alarmInfo.dayTime, alarmInfo.music, alarmInfo.id]
    );
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+2);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+3);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+4);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+5);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+6);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+7);
    await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+8);
    if(alarmInfo.isPending == 0){
      await scheduleAlarm(alarmInfo.alarmDateTime, alarmInfo.title, alarmInfo.dayTime, alarmInfo.music, alarmInfo.id);
    }
    return res;
  }

  Future<int> activeOrUnActiveAlarm(AlarmInfo alarmInfo)async{
    var db = await this.database;
    int tmp = 0;
    if(alarmInfo.isPending == 0){
      tmp = 1;
    }
    var res = await db.rawUpdate('''
    UPDATE ${tableAlarm} 
    SET ${columnPending} = ? 
    WHERE ${columnId} = ?
    ''',
        [tmp, alarmInfo.id]);
    if(alarmInfo.isPending == 0){
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+2);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+3);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+4);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+5);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+6);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+7);
      await flutterLocalNotificationsPlugin.cancel(alarmInfo.id+8);
    }else{
      await scheduleAlarm(alarmInfo.alarmDateTime, alarmInfo.title, alarmInfo.dayTime, alarmInfo.music, alarmInfo.id);
    }
    return res;
  }
  void scheduleAlarm(DateTime dateTime,String title, String dayTime, String music, int id)async{
    var androidMusic = music.split(".");
    Time scheduleNotificationTime = Time(dateTime.hour, dateTime.minute, dateTime.second);
    var androidNotificationDetails = AndroidNotificationDetails(
        "channelId",
        "channelName",
        "channelDescription",
        icon: "phu_logo",
        sound: RawResourceAndroidNotificationSound('${androidMusic[0]}'),
        largeIcon: DrawableResourceAndroidBitmap('phu_logo')
    );
    var iosNotificationDetails = IOSNotificationDetails(
        sound: '${music}',
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails
    );
    dateTime.isAfter(DateTime.now()) == true ?
      await flutterLocalNotificationsPlugin.schedule(
          id,
          title,
          "Alarm & Notebook",
          dateTime,
          platformChannelSpecifics
      ):
        print(DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second));
    await flutterLocalNotificationsPlugin.schedule(
        id,
        title,
        "Alarm & Notebook",
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second),
        platformChannelSpecifics
    );
    // ignore: deprecated_member_use
    var tmp = dayTime.split(",");
    for(int i = 0 ; i< tmp.length; i++){
      if(tmp[i] == "2"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+2,
            title,
            "Alarm & Notebook",
            Day.monday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "3"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+3,
            title,
            "Alarm & Notebook",
            Day.tuesday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "4"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+4,
            title,
            "Alarm & Notebook",
            Day.wednesday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "5"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+5,
            title,
            "Alarm & Notebook",
            Day.thursday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "6"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+6,
            title,
            "Alarm & Notebook",
            Day.friday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "7"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+7,
            title,
            "Alarm & Notebook",
            Day.saturday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
      if(tmp[i] == "8"){
        await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
            id+8,
            title,
            "Alarm & Notebook",
            Day.sunday,
            scheduleNotificationTime,
            platformChannelSpecifics
        );
      }
    }

  }
}