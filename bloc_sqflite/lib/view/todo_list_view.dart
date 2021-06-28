import 'package:bloc_sqflite/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:bloc_sqflite/helper/helper_widget.dart' as helper;

class TodoListScreen extends StatelessWidget {
  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  final List<Todo> todoList;
  Function deleteById;
  Function updateTodo;

  TodoListScreen(
      {Key? key,
      required this.todoList,
      required this.deleteById,
      required this.updateTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, itemPosition) {
          Todo todo = todoList[itemPosition];
          final Widget dismissibleCard = Dismissible(
              background: Container(
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.redAccent,
              ),
              onDismissed: (direction) {
                deleteById(todo.id);
              },
              direction: _dismissDirection,
              key: ObjectKey(todo),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: InkWell(
                    onTap: () {
                      todo.isDone = !todo.isDone;
                      updateTodo(todo);
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: todo.isDone
                            ? const Icon(
                                Icons.done,
                                size: 26,
                                color: Colors.indigoAccent,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank,
                                size: 26,
                                color: Colors.tealAccent,
                              ),
                      ),
                    ),
                  ),
                  title: Text(
                    todo.description,
                    style: TextStyle(
                        fontSize: 16.5,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w500,
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            enableFeedback: true,
                            onPressed: () {
                              if (todo.isDone) {
                                helper.showSnackBar(
                                    "Can't edit this item", context);
                              } else {
                                _showEditDialog(todo, context);
                              }
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () =>
                                helper.shareContent(todo.description),
                            icon: const Icon(Icons.share))
                      ]),
                ),
              ));
          return dismissibleCard;
        });
  }

  _showEditDialog(Todo todo, BuildContext context) {
    String description = todo.description;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit your todo"),
            content: TextFormField(
              onChanged: (value) {
                description = value;
              },
              maxLines: 2,
              initialValue: todo.description,
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () async {
                    if (description.isNotEmpty) {
                      todo.description = description;
                      await updateTodo(todo);
                      Navigator.pop(context);
                      helper.showSnackBar("Successfully updated!", context);
                    } else {}
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }
}
