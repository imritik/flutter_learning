import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/post.dart';
import 'package:flutter_mvvm/notifiers/post_notifier.dart';
import 'package:provider/provider.dart';

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

  _createPost(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      _showSnackBar("Failed to create Post", context);
      return;
    }
    _formKey.currentState.save();
    _post.userId = 1;

    PostsNotifier postNotifier = Provider.of(context, listen: false);
    _post.id = postNotifier.getPostList().length + 1;
    postNotifier.uploadPost(_post).then((value) {
      if (value) {
        _showSnackBar("post added successfully", context);
      }
    });
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
                  if (value.length < 5 || value.length > 50) {
                    return 'Post title must be between 5 and 50 characters';
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
                maxLines: 7,
                decoration: InputDecoration(
                    labelText: "Post Body", alignLabelWithHint: true),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Post body cannot be empty';
                  }

                  if (value.length < 5 || value.length > 100) {
                    return 'Post body must be between 5 and 100 characters';
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
