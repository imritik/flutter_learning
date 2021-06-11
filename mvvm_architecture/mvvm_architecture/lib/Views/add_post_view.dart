import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Model/PostModel.dart';
import 'package:mvvm_architecture/ViewModel/api_viewModel.dart';

class AddPostScreen extends StatefulWidget {
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Post _post = new Post();

  _showSnackBar(String text, BuildContext context) {
    final snackbar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    // ScaffoldMessenger.showSnackBar(snackbar);
  }

  _createPost(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      _showSnackBar("Failed to create Post", context);
      return;
    }
    _formKey.currentState.save();

    await ApiViewmodel.postData();
    _showSnackBar("Post created", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Create a Post'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: 16,
              ),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Post title"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Post title cannot be empty";
                  }

                  return null;
                },
                onSaved: (String value) {
                  _post.title = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 16),
              child: TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: "Post Body", alignLabelWithHint: true),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Post title cannot be empty";
                  }

                  return null;
                },
                onSaved: (String value) {
                  _post.body = value;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
              child: RaisedButton(
                onPressed: () {
                  _createPost(context);
                },
                child: Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
