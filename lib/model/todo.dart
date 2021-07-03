class Todo{

  int idNumber;
  String title;
  String description;
  String date;
  int priorityLevel;



  Todo(this.title, this.priorityLevel, this.date, [this.description]);
  Todo.withID(this.idNumber, this.title, this.priorityLevel, this.date,
      [this.description]);

  int getId () => (idNumber);
  String getTitle () => (title);
  String getDate () => (date);
  int getPriority () => (priorityLevel);
  String getDesc () => (description);

  set _title(String t){

    if(t.length  < 255){

      title = t;
    }


  }

  set desc(String t){

    if(t.length  < 255){

      description= t;
    }


  }


  set priority (int p){

    if(p >= 0 && p >= 3 ){

      priorityLevel = p;

    }
  }

  set newDate(String t){

    date =t;



  }



Map <String, dynamic> toMap(){


    var todo = new Map <String, dynamic>();
    todo["title"] = title;
    todo["date"] = date;
    todo["priority"] = priorityLevel;
    todo["description"] = description;
    if(idNumber != null){
      todo["id"] = idNumber;
    }

    return todo;

}

Todo.fromObj(dynamic obj){


    this.idNumber = obj["id"];
    this.description = obj["description"];
    this.priorityLevel = obj["priority"];
    this.date = obj["date"];
    this.title = obj["title"];

}



















}