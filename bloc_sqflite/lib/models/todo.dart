class Todo {
  int id;
  String description;
  bool isDone = false;
  Todo({required this.description, this.isDone = false, this.id = 0});

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        //This will be used to convert JSON objects into a Todo object
        id: data['id'],
        description: data['description'],
        //Since sqlite doesn't have boolean type for true/false
        //we will 0 to denote that it is false
        //and 1 for true
        isDone: data['is_done'] == 0 ? false : true,
      );
  Map<String, dynamic> toDatabaseJson() => {
        // "id": id,
        "description": description,
        "is_done": isDone == false ? 0 : 1,
      };
}
