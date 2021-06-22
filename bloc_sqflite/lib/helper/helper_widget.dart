import 'package:flutter/material.dart';

Widget noTodoMessageWidget() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: const Text(
      "Start adding Todo...",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    ),
  );
}

Widget loadingData() {
  // todoBloc.getTodos();
  // ignore: avoid_unnecessary_containers
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        // ignore: prefer_const_constructors
        CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        // ignore: prefer_const_constructors
        Text(
          "Loading ...",
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

showSnackBar(dynamic value, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(value)));
}
