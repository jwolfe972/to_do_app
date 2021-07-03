import 'package:flutter/material.dart';
import 'package:to_do_app/util/dbhelper.dart';
import 'package:to_do_app/screens/todolist.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:intl/intl.dart';
final List<String> choices =
    const <String>[
      'Save and Return',
      'Delete Todo',
      'Back'

    ];
DBHelper helper = new DBHelper();

const menuSave = 'Save and Return';
const menuDelete = 'Delete Todo';
const menuBack = 'Back';

class TodoDetail extends StatefulWidget{
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() {


    return   TodoDetailState(todo);




    throw UnimplementedError();
  }



}

class TodoDetailState extends State{

  Todo todo;
  TodoDetailState(this.todo);
  final _priorities = ["High", "Medium", "Low"];
  String _priotity = "Low";
  TextEditingController titleOfTask = new TextEditingController();
  TextEditingController descOfTask = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    titleOfTask.text = todo.title;
    descOfTask.text = todo.description;
    TextStyle tS = Theme.of(context).textTheme.title;


    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        title: Text(todo.title),
        actions: <Widget>[
          PopupMenuButton<String> (
            onSelected: select ,
            itemBuilder: (BuildContext context){


              return choices.map((String choice ){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),

                );
              }).toList();

            }
          )
        ],


      ),

      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[

          Column(
              children: <Widget>[

                TextField(
                  controller: titleOfTask ,
                  style: tS,
                  onChanged:  (value) => this.updateTitle(),
                  decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: tS,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ) ,


                ),
                Padding(padding: EdgeInsets.all(10.0)),

                TextField(
                  controller: descOfTask,
                  style: tS,
                  onChanged: (value) => this.updateDesc(),
                  decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: tS,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ) ,


                ),

                ListTile(title:   DropdownButton<String>(

                  items: _priorities.map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  )).toList(),
                  onChanged: (String value){

                    updatePriority(value);

                  },
                  value: _priotity,

                )
                  ),


              ]
          ),



        ]),


      ),
    );


    throw UnimplementedError();
  }

  void _onDropDownChanged(String s){


    setState(() {
      this._priotity = s;
    });
  }


  void select(String v) async{

    int rs;


    switch(v){

      case menuSave:
        save();
        break;
      case menuDelete:
        Navigator.pop(context, true);
        String nameOfTask = todo.getTitle();
        if (todo.idNumber == null){
          return;
        }
        rs = await helper.deleteToDo(todo.getId());
        if (rs != 0){

          AlertDialog aD = new AlertDialog(
            title: Text('Delete Task'),
            content: Text('The task ' + nameOfTask + ' has been deleted.'),
          );
          
          showDialog(context: context,builder: (_) => aD );


        }
        break;

      case menuBack:
        Navigator.pop(context, true);
        break;
      default:
        break;



    }
  }



  void save(){

    todo.date = new DateFormat.yMd().format(DateTime.now());
    if (todo.idNumber != null ){

      helper.updateTodo(todo);
    }

    else{
      helper.insertTodo(todo);

    }

    Navigator.pop(context, true);

  }


  void updatePriority(String v){


    switch(v){


      case "High":
        todo.priorityLevel = 3;
        break;
      case "Medium":
        todo.priorityLevel = 2;
        break;

      case "Low":
        todo.priorityLevel = 1;
        break;
        
        




    }
    _onDropDownChanged(v);

    //
    // setState(() {
    //
    // });
    //


  }

  String retrievePriority(int v){

    return _priorities[v-1];


  }

  void updateTitle(){
    todo.title = titleOfTask.text;
  }
  void updateDesc(){
    todo.description = descOfTask.text;
  }



}