import 'package:alarm_clock_flutter/app/modules/alarm/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';


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
          $columnColorIndex integer
          )
          ''');
        }
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async{
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
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
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> activeOrUnActiveAlarm(AlarmInfo alarmInfo)async{
    var db = await this.database;
    int tmp = 0;
    if(alarmInfo.isPending == 0){
      tmp = 1;
    }
    return await db.rawUpdate('''
    UPDATE ${tableAlarm} 
    SET ${columnPending} = ? 
    WHERE ${columnId} = ?
    ''',
        [tmp, alarmInfo.id]);
  }
}