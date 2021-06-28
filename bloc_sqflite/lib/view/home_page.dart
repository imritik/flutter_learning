import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:bloc_sqflite/helper/camera_options.dart' as camera_helper;
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
  List<Todo> todoList = [];
  // ignore: prefer_typing_uninitialized_variables
  var backgroundImg;

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
        // centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(todoList));
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
              child: CircleAvatar(
                // ignore: unnecessary_null_comparison
                child: ClipOval(
                  child: (backgroundImg != null)
                      ? Image.file(
                          backgroundImg,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        )
                      : Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                ),
              )),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(
                        Icons.open_in_browser,
                        color: Colors.indigo,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Open Web url")
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.indigo,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Open email ")
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(
                        Icons.call_made_outlined,
                        color: Colors.indigo,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Open dialer")
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 3,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(
                        Icons.attach_file_outlined,
                        color: Colors.indigo,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Share images")
                    ],
                  )),
            ],
            onSelected: (item) => helper.selectedItem(context, item),
          )
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
                        _optionsDialogBox();
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
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

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: const Text('Take a picture'),
                      onTap: () {
                        camera_helper.openCamera();
                        Navigator.pop(context);
                      }),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                      child: const Text('Record video'),
                      onTap: () {
                        camera_helper.recordVideo();
                        Navigator.pop(context);
                      }),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                      child: const Text('Select image from gallery'),
                      onTap: () async {
                        final imageFile = await camera_helper.openGallery();
                        setState(() {
                          backgroundImg = imageFile;
                        });
                        Navigator.pop(context);
                        helper.showSnackBar(
                            "Image successfully updated!", context);
                      }),
                ],
              ),
            ),
          );
        });
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
                      deleteById: todoBloc.deleteTodoById,
                      updateTodo: todoBloc.updateTodo,
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
