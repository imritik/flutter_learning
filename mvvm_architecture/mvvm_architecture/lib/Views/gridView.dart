import 'package:flutter/material.dart';
import 'package:mvvm_architecture/ViewModel/api_viewModel.dart';
import 'package:mvvm_architecture/Views/add_post_view.dart';

class gridview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiViewmodel.loadData();
    return new Scaffold(
        appBar: AppBar(
          title: Text("MVVM Demo"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPostScreen()));
                })
          ],
        ),
        body: new GridView.count(
            crossAxisCount: 2,
            children: ApiViewmodel.newPostList != null
                ? new List<Widget>.generate(ApiViewmodel.newPostList.length,
                    (index) {
                    return new GridTile(
                        child: new Card(
                            color: Colors.blue.shade200,
                            child: Row(children: [
                              Expanded(
                                flex: 2,
                                child: new Text(
                                    ApiViewmodel.newPostList[index].title),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))
                            ])));
                  })
                : Text("No Data found !")));
  }
}
