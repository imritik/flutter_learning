import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:bloc_sqflite/helper/helper_widget.dart' as helper;
import 'package:bloc_sqflite/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key? key, required this.title}) : super(key: key);
  final TodoBloc todoBloc = TodoBloc();
  final String title;

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Container(
            child: getTodosWidget(),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          )),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    todoBloc.getTodos();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.indigoAccent,
                    size: 28,
                  )),
              const Expanded(
                  child: Text(
                "Todo",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RobotoMono',
                    fontStyle: FontStyle.normal,
                    fontSize: 19),
              )),
              Wrap(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        _showTodoSearchSheet(context);
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.indigoAccent,
                      )),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: FloatingActionButton(
          elevation: 5,
          onPressed: () {
            _showAddTodoSheet(context);
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, size: 32, color: Colors.indigoAccent),
        ),
      ),
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    final _todoDescriptionController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 25, bottom: 30, right: 15),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'I have to...',
                                  labelText: 'New Todo',
                                  // errorText: _validateInputString(
                                  //     _todoDescriptionController.value.text),
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Empty description!';
                              //   }
                              //   return value.contains('@')
                              //       ? 'Do not use @ char.'
                              //       : null;
                              // },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                                backgroundColor: Colors.indigoAccent,
                                radius: 18,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.save,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      final newTodo = Todo(
                                        description: _todoDescriptionController
                                            .value.text,
                                      );
                                      if (newTodo.description.isNotEmpty) {
                                        todoBloc.addTodo(newTodo);
                                        Navigator.pop(context);
                                      }
                                    })),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showTodoSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search for todo...',
                                labelText: 'Search *',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              // validator: (value) {
                              //   return value!.contains('@')
                              //       ? 'Do not use the @ char.'
                              //       : null;
                              // },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                  todoBloc.getTodos(
                                      query:
                                          _todoSearchDescriptionFormController
                                              .value.text);
                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getTodosWidget() {
    return RefreshIndicator(
        onRefresh: () => todoBloc.getTodos(),
        child: StreamBuilder(
          stream: todoBloc.todos,
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            return getTodoCardWidget(snapshot);
          },
        ));
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Todo>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data!.isNotEmpty
          ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, itemPosition) {
                Todo todo = snapshot.data![itemPosition];
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
                    todoBloc.deleteTodoById(todo.id);
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
                          todoBloc.updateTodo(todo);
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
                      trailing: IconButton(
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
                    ),
                  ),
                );
                return dismissibleCard;
              })
          // ignore: avoid_unnecessary_containers
          : Container(
              child: Center(
                child: helper.noTodoMessageWidget(),
              ),
            );
    } else {
      return Center(
        child: helper.loadingData(),
      );
    }
  }

  _showEditDialog(Todo todo, BuildContext context) {
    String description = '';
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
                      await todoBloc.updateTodo(todo);
                      Navigator.pop(context);
                      helper.showSnackBar("Successfully updated!", context);
                    } else {
                      // return "Empty Description";
                    }
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  dispose() {
    todoBloc.dispose();
  }
}
