import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/util/dbhelper.dart';
import 'package:to_do_app/screens/tododetail.dart';




class ToDoList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ToDoListState();




}


class ToDoListState extends State{
  DBHelper helper = new DBHelper();
List<Todo> todoList;
int count = 0;



  @override
  Widget build(BuildContext context) {


    if(todoList == null){
      todoList = List<Todo>();
      getData();
    }






    return Scaffold(
      body: Container(child: toDoListItems(),



      ),
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToDetailScreen(Todo('New Task', 1, ''));

        },
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),


      ),




    );
    // TODO: implement build
    throw UnimplementedError();
  }
  ListView toDoListItems(){

      return ListView.builder(itemCount: this.count,
      itemBuilder: (BuildContext context, int pos){

        return Card(
          color: Colors.blueGrey,

              elevation: 2.2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.todoList[pos].priorityLevel),
              child: Text(setPriority(this.todoList[pos].priorityLevel),
                  style: TextStyle(color: Colors.white,
                    fontSize: 10.0,
                  )),
            ),

            title: Text(this.todoList[pos].title),
            subtitle: Text(this.todoList[pos].date),
            onTap: (){
              debugPrint("Tapped on " + this.todoList[pos].priorityLevel.toString());
              navigateToDetailScreen(this.todoList[pos]);
            },


          ),

        );
      },);

  }


  void getData(){

    final dbFuture = helper.initializeDb();
    dbFuture.then(
        (result){
          final ToDoFuture = helper.getTodos();
          ToDoFuture.then((value){

            List<Todo> todoList = new List<Todo>();
            count = value.length;
            for(int i = 0; i < count; ++i){
              todoList.add(Todo.fromObj(value[i]));
              debugPrint(todoList[i].getTitle());
            }


            setState(() {


              this.todoList = todoList;
              this.count = count;

            });

          });

        }

    );

  }


  Color getColor(int p){

    switch (p){

      case 1:
          return Colors.greenAccent;
          break;
      case 2:
          return Colors.orangeAccent;
      case 3:
          return Colors.red;
      default:
        return Colors.greenAccent;
        break;


    }
  }

  String setPriority(int i){


    switch (i){

      case 1:
        return "Low";
        break;
      case 2:
        return "Medium";
      case 3:
        return "High";


    }


  }

  void navigateToDetailScreen(Todo t) async{

    bool result = await Navigator.push(context,
    MaterialPageRoute(
      builder: ((context) => TodoDetail(t))
    ));

    if(result ==  true){
      getData();

    }

  }
  
  
  
}