import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:bloc_sqflite/helper/helper_widget.dart' as helper;
import 'package:bloc_sqflite/models/todo.dart';
import 'package:bloc_sqflite/view/serach_delegate.dart';
import 'package:bloc_sqflite/view/todo_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoBloc todoBloc = TodoBloc();
  final DismissDirection _dismissDirection = DismissDirection.horizontal;
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: Colors.white,
    //     systemNavigationBarColor: Colors.white,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.dark));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(todoList));
              },
              icon: const Icon(Icons.search))
        ],
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
                                  labelStyle: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500)),
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
                                      if (_todoDescriptionController
                                          .value.text.isNotEmpty) {
                                        final newTodo = Todo(
                                          description:
                                              _todoDescriptionController
                                                  .value.text,
                                        );
                                        if (newTodo.description.isNotEmpty) {
                                          todoBloc.addTodo(newTodo);
                                          Navigator.pop(context);
                                        }
                                      } else {}
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
                                  if (_todoSearchDescriptionFormController
                                      .value.text.isNotEmpty) {
                                    todoBloc.getTodos(
                                        query:
                                            _todoSearchDescriptionFormController
                                                .value.text);
                                  } else {
                                    todoBloc.getTodos();
                                  }

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
            if (snapshot.hasData) {
              todoList = snapshot.data!;
              return snapshot.data!.isNotEmpty
                  ? TodoListScreen(
                      todoList: snapshot.data!,
                      // todoBloc: todoBloc,
                    )
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
          },
        ));
  }

  @override
  dispose() {
    todoBloc.dispose();
    super.dispose();
  }
}
