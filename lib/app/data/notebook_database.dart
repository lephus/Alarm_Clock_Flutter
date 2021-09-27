import 'package:alarm_clock_flutter/app/modules/notebook/notebook_info.dart';
// import 'package:alarm_clock_flutter/app/modules/timeZone/local_data_info.dart';
import 'package:alarm_clock_flutter/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';

final String tableNotebook = 'notebook';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDescription = "description";
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';


// final String tableLocal = 'dataLocal';
// final String columnIdLocal = 'id';
// final String columnTitleLocal = 'title';
// final String columnCodeNumber = 'codeNumber';
// final String columnNote = 'note';
// index 0 => language
// index 1 => list Zomtime


class NotebookDatabase{
  static Database _database;
  static NotebookDatabase _notebookDatabase;

  NotebookDatabase._createInstance();
  factory NotebookDatabase(){
    if (_notebookDatabase == null){
      _notebookDatabase = NotebookDatabase._createInstance();
    }
    return _notebookDatabase;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    var dir = await getDatabasesPath();
    var path = dir + 'notebook.db';
    var database = openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $tableNotebook (
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDescription text not null,
          $columnDateTime text not null,
          $columnPending integer
          )
          ''');
        }
    );
    // create table localData
    // openDatabase(
    //     path,
    //     version: 1,
    //     onCreate: (db, version) {
    //       db.execute('''
    //       CREATE TABLE $tableLocal (
    //       $columnIdLocal integer primary key autoincrement,
    //       $columnTitleLocal text not null,
    //       $columnCodeNumber integer,
    //       $columnNote text not null,
    //       )
    //       ''');
    //     }
    // );
    // // 0 vietnamese
    // // 1 english
    // var defineLanguage = LocalDataInfo(
    //     id: 0,
    //     title: 'language',
    //     codeNumber: 0,
    //     note: ''
    // );
    // var db = await this.database;
    // await db.insert(tableLocal, defineLanguage.toMap());

    return database;
  }

  Future<int> insertNotebook(NotebookInfo notebookInfo) async{
    var db = await this.database;
    var tmp = await db.insert(tableNotebook, notebookInfo.toMap());
    notebookInfo.isPending == 0 ?
    await scheduleNotebook(notebookInfo.alarmDateTime, notebookInfo.title, notebookInfo.description, notebookInfo.id)
    : null;
    return tmp;
  }

  Future<List<NotebookInfo>> getNotebooks() async{
    List<NotebookInfo> _notes = [];
    var db = await this.database;
    var result = await db.query(tableNotebook);
    result.forEach((element) {
      var note = NotebookInfo.fromMap(element);
      _notes.add(note);
    });
    return _notes;
  }

  Future<int> deleteNotebook(int id) async{
    var db = await this.database;
    var res = await db.delete(tableNotebook, where: '$columnId = ?', whereArgs: [id]);
    await flutterLocalNotificationsPlugin.cancel(id);
    return res;
  }

  Future<int> activeOrUnActiveNotebook(NotebookInfo notebookInfo)async{
    var db = await this.database;
    int tmp = 0;
    if(notebookInfo.isPending == 0){
      tmp = 1;
    }
    var res = await db.rawUpdate('''
    UPDATE ${tableNotebook} 
    SET ${columnPending} = ? 
    WHERE ${columnId} = ?
    ''',
        [tmp, notebookInfo.id]);
    if(notebookInfo.isPending == 0){
      await flutterLocalNotificationsPlugin.cancel(notebookInfo.id);
    }else{
      await scheduleNotebook(notebookInfo.alarmDateTime, notebookInfo.title, notebookInfo.description, notebookInfo.id);
    }
    return res;
  }

  Future<int> updateNotebook(NotebookInfo notebookInfo)async{
    var db = await this.database;
    var res = await db.rawUpdate('''
    UPDATE ${tableNotebook} 
    SET 
    ${columnTitle} = ?,
    ${columnDescription} = ?,
    ${columnDateTime} = ?,
    ${columnPending} = ? 
    WHERE ${columnId} = ?
    ''',
        [notebookInfo.title, notebookInfo.description, notebookInfo.alarmDateTime.toString(), notebookInfo.isPending ,notebookInfo.id]);
    if(notebookInfo.isPending == 0){
      await scheduleNotebook(notebookInfo.alarmDateTime, notebookInfo.title, notebookInfo.description, notebookInfo.id);
    }else{
      await flutterLocalNotificationsPlugin.cancel(notebookInfo.id);
    }
    return res;
  }
  bool checkBigDateTime(DateTime dateTime){
    var time = DateTime.now();
    if( time.year > dateTime.year){
      return false;
    }else{
      if (time.month > dateTime.month){
        return false;
      }else{
        if (time.day > dateTime.day){
          return false;
        }else{
          if (time.hour > dateTime.hour){
            return false;
          }else{
            if (time.minute > dateTime.minute){
              return false;
            }
          }
        }
      }
    }
    return true;
  }
  void scheduleNotebook(DateTime dateTime,String title, String des, int id)async{
    if(checkBigDateTime(dateTime) == false){
      return;
    }
    var scheduleNotificationDateTime = dateTime;
    var androidNotificationDetails = AndroidNotificationDetails(
        "channelId",
        "channelName",
        "channelDescription",
        icon: "phu_logo",
        sound: RawResourceAndroidNotificationSound('alarm_ringtone'),
        largeIcon: DrawableResourceAndroidBitmap('phu_logo')
    );
    var iosNotificationDetails = IOSNotificationDetails(
        sound: 'alarm_ringtone.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails
    );
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        id,
        title,
        des,
        scheduleNotificationDateTime,
        platformChannelSpecifics
    );
  }

  // void insertLocalData(LocalDataInfo localDataInfo) async{
  //   var db = await this.database;
  //   await db.insert(tableLocal, localDataInfo.toMap());
  // }
  //
  // Future<List<LocalDataInfo>> getLocalData() async{
  //   List<LocalDataInfo> _localData = [];
  //   var db = await this.database;
  //   var result = await db.query(tableLocal);
  //   result.forEach((element) {
  //     var tmp = LocalDataInfo.fromMap(element);
  //     _localData.add(tmp);
  //   });
  //   return _localData;
  // }
  //
  // Future<int> deleteLocalData(int id) async{
  //   var db = await this.database;
  //   var res = await db.delete(tableLocal, where: '$columnIdLocal = ?', whereArgs: [id]);
  //   return res;
  // }
  //
  // Future<int> updateLanguage(int id)async{
  //   var db = await this.database;
  //   var res = await db.rawUpdate('''
  //   UPDATE ${tableLocal}
  //   SET
  //   ${columnCodeNumber} = ?
  //   WHERE ${columnIdLocal} = ?
  //   ''',
  //       [id ,0]);
  //   return res;
  // }
}