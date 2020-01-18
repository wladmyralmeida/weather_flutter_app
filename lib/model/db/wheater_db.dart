import 'dart:async';

import 'package:my_weather_app/model/weather.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDB {
  static final WeatherDB _instance = new WeatherDB.getInstance();

  factory WeatherDB() => _instance;

  WeatherDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Weathers.db');
    print("db $path");

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Weather(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT'
            ', desc TEXT, urlFoto TEXT, urlVideo TEXT, lat TEXT, lng TEXT)');
  }

  Future<List<Weather>> getWeathers() async {
    final dbClient = await db;

    final mapWeathers = await dbClient.rawQuery('select * from Weather');

    final weathers = mapWeathers.map<Weather>((json) => Weather.fromJson(json)).toList();

    return weathers;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from Weather');
    return Sqflite.firstIntValue(result);
  }

  Future<Weather> getWeather(int id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from Weather where id = ?',[id]);

    if (result.length > 0) {
      return new Weather.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Weather weather) async {
    Weather c = await getWeather(weather.id);
    var exists = c != null;
    return exists;
  }

  Future<int> deleteWeather(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from Weather where id = ?',[id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
