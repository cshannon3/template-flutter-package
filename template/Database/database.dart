import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';
import 'package:{{_ "camelCase" name}}/Models/db_model.dart';

import '../Models/db_model.dart';
class {{_ "camelCase" dbname}}Database {
  // want to create an instance of our movie db inside our moviedb class
  static final {{_ "camelCase" dbname}}Database _instance = GameHistoryDatabase._internal();

  //factory allows you to create many instances of your database
  factory {{_ "camelCase" dbname}}Database() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  {{_ "camelCase" dbname}}Database._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDB = await openDatabase(path, version: 3, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE {{_ "camelCase" dbname}}(${SampleDBModel.sqlTable()} )''');

    print("Database was Created!");

  }

  Future<int> addGame(SampleDBModel dbmodel) async {
    var dbClient = await db;
    int res = await dbClient.insert("{{_ "camelCase" dbname}}", dbmodel.toMap());
    return res;
  }

  Future<List<SampleDBModel>> getAllHistory() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("{{_ "camelCase" dbname}}");
    return res.map((m) => SampleDBModel.fromOfflineDB(m)).toList();
  }

}