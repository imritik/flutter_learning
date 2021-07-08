import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewScreen extends StatelessWidget {
  String payload;

  // ignore: use_key_in_widget_constructors
  NewScreen({required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}
