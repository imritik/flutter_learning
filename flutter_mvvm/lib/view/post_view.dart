import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/post.dart';
import 'package:flutter_mvvm/view/edit_post_view.dart';
import 'package:flutter_mvvm/view_model/post_view_model.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView({@required this.post});
  PostViewState createState() => PostViewState(post);
}

class PostViewState extends State<PostView> {
  Post post;
  PostViewModel postViewModel;

  PostViewState(this.post) {
    postViewModel = new PostViewModel();
    postViewModel.setPost(post);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            postViewModel.post.id.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            postViewModel.post.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditPostScreen(postViewModel)));
                                })),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Divider(
                height: 1,
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(postViewModel.post.body),
              ),
            ),
            Expanded(
              flex: 0,
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
