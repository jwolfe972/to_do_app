import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app/model/todo.dart';


class DBHelper{


static final DBHelper _dbhelper = DBHelper.internal();
String nameOfTab = "todos";
String col_1 = "id";
String col_2 = "priority";
String col_3 = "title";
String col_4 = "date";
String col_5 = "description";


static Database THIS_IS_THE_DATABASE;

Future<Database> get db async{

  if(THIS_IS_THE_DATABASE == null){
    THIS_IS_THE_DATABASE = await initializeDb();
  }

  return THIS_IS_THE_DATABASE;

}
DBHelper.internal();



factory DBHelper(){


  return _dbhelper;
}



Future<Database>initializeDb() async{
  Directory dir = await getApplicationDocumentsDirectory();

  String path = dir.path + "todos.db";
  var dbTodo = await openDatabase(path, version: 1, onCreate: _createDb );


  return dbTodo;


}


 void _createDb(Database db, int newVersion) async{

  await db.execute(

    "CREATE TABLE $nameOfTab ("
        "$col_1 INTEGER PRIMARY KEY NOT NULL,"
        "$col_2 INTEGER NOT NULL,"
        "$col_3 VARCHAR(254) NOT NULL,"
        "$col_4 DATE NOT NULL,"
        "$col_5 VARCHAR(254)"
        ");"

  );





}

Future<int> insertTodo(Todo todo) async{


  Database db = await this.db;

  var rS = await db.insert(nameOfTab, todo.toMap());

  return rS;


}


Future<List> getTodos() async{


  Database db = await this.db;
  var rS = await db.rawQuery("SELECT * FROM $nameOfTab "
      "ORDER BY $col_2 DESC;");


  return rS;




}

Future<int> getNumOfRecords() async{

  Database db = await this.db;

  var rs = Sqflite.firstIntValue(

   await db.rawQuery("SELECT COUNT(*) FROM $nameOfTab;")
  );


  int s = await rs;


  print(s);


  return rs;


}

Future<int> updateTodo(Todo t) async{

  var db = await this.db;
  var rS = await db.update(nameOfTab, t.toMap(),
  where: "$col_1 = ?", whereArgs: [t.idNumber]);

  return rS;




}


Future <int> deleteToDo(int i) async{
  
  
  var db = await this.db;
  
 var rS = await db.rawDelete("DELETE FROM $nameOfTab WHERE $col_1 = $i");
  

  return rS;


}

Future <int> insertOne() async{
  DateTime now = new DateTime.now();

  var rs = await insertTodo(new Todo("ubvuyv", 3, now.toString()));

  return rs;


}




Future <int> deleteAllTasks() async{


  var db = await this.db;

  var rS = await db.rawDelete("DELETE FROM $nameOfTab");


  return rS;


}












}