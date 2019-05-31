//TODO way to set up local or firebase database

{{#if (eq dbname "y")}}
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
{{/if}}


import 'dart:async';
import 'dart:io';
import 'package:{{{name}}}/Models/db_model.dart';
/*
// TODO check if this works
class {{{dbname}}}Database {
  // want to create an instance of our movie db inside our moviedb class
  static final {{{dbname}}}Database _instance = {{{dbname}}}Database._internal();

  //factory allows you to create many instances of your database
  factory {{{dbname}}}Database() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  {{{dbname}}}Database._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDB = await openDatabase(path, version: 3, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE {{_ "camelCase" dbname}}(${sqlTableString} )''');

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

}*/