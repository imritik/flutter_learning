import 'package:flutter/material.dart';
import 'package:flutter_mvvm/notifiers/post_notifier.dart';
import 'package:flutter_mvvm/services/api_service.dart';
import 'package:flutter_mvvm/view/post_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    PostsNotifier postNotifier =
        Provider.of<PostsNotifier>(context, listen: false);
    ApiService.getPosts(postNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostsNotifier postNotifier = Provider.of<PostsNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter MVVM'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, "/add_post");
                })
          ],
        ),
        body: postNotifier != null
            ? Container(
                color: Colors.black,
                child: ListView.builder(
                    itemCount: postNotifier.getPostList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(0),
                        key: ObjectKey(postNotifier.getPostList()[index]),
                        child:
                            PostView(post: postNotifier.getPostList()[index]),
                      );
                    }),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
