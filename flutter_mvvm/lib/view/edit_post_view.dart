import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/post.dart';
import 'package:flutter_mvvm/notifiers/post_notifier.dart';
import 'package:flutter_mvvm/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  EditPostScreen(this.post);
  final PostViewModel post;
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Post _post = new Post();

  _showSnackBar(String text, BuildContext context) {
    final snackbar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    // ScaffoldMessenger.showSnackBar(snackbar);
  }

  _updatePost(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      _showSnackBar("Failed to update Post", context);
      return;
    }
    _formKey.currentState.save();
    _post.userId = widget.post.post.userId;
    _post.id = widget.post.post.id;
    PostsNotifier postNotifier = Provider.of(context, listen: false);

    postNotifier.updatePost(_post).then((value) {
      if (value) {
        _showSnackBar("post updated successfully", context);
      } else {
        _showSnackBar("Unable to update post", context);
      }
    });
  }

  _deletePost(BuildContext context) {
    PostsNotifier postNotifier = Provider.of(context, listen: false);
    postNotifier.deletePost(widget.post.post.id).then((value) {
      if (value) {
        _showSnackBar("post deleted successfully", context);
      } else {
        _showSnackBar("Unable to delete post", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Post'),
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
                initialValue: widget.post.post.title,
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
                  labelText: "Post Body",
                ),
                initialValue: widget.post.post.body,
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
                child: Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _updatePost(context);
                      },
                      child: Text('Update'),
                    ),
                    SizedBox(
                      //Use of SizedBox
                      width: 30,
                    ),
                    RaisedButton(
                      onPressed: () {
                        _deletePost(context);
                      },
                      child: Text('Delete'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
