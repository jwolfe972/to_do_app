import 'package:flutter/material.dart';
import 'package:to_do_app/util/dbhelper.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/screens/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo",
      theme: new ThemeData(
          primarySwatch: Colors.lightGreen

      ),
      home: new MyHome(),

    );








    // TODO: implement build
    throw UnimplementedError();
  }

}


class MyHome extends StatelessWidget{




  @override
  Widget build(BuildContext context) {
    //
    // DBHelper db = new DBHelper();
    // db.deleteAllTasks();
    //
    // db.insertOne();





    return new Scaffold(
      appBar:  new AppBar(
        title: Text('To Do App'),

      ),



      body: ToDoList(),
    );

    throw UnimplementedError();
  }

}
