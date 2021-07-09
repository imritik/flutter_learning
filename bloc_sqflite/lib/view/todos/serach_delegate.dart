import 'package:bloc_sqflite/blocs/todo_bloc.dart';
import 'package:bloc_sqflite/models/todo.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  Todo selectedResult = Todo(description: '', pickedDate: '');

  final List<Todo> todos;
  Search(this.todos);

  final TodoBloc todoBloc = TodoBloc();
  @override
  List<Widget>? buildActions(BuildContext context) {
    // These widgets are on the right side of the text field

    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // It's a single widget on the left of the search field
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Center(
      child: Text(selectedResult.description),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Todo> suggestionList = [];
    query.isEmpty
        ? suggestionList = todos
        : suggestionList.addAll(
            todos.where((element) => element.description.contains(query)));

    return suggestionList.isNotEmpty
        ? ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  suggestionList[index].description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  selectedResult = suggestionList[index];
                  showResults(context);
                },
              );
            })
        : const Center(
            child: Text(
              "Nothing found!",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          );
  }
}
