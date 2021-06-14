import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Model/PostModel.dart';
import 'package:mvvm_architecture/Service/apiservice.dart';
import 'package:mvvm_architecture/ViewModel/api_viewModel.dart';
import 'package:mvvm_architecture/Views/add_post_view.dart';

class gridview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ApiViewmodel.loadData();
    final postList = ApiViewmodel.newPostList;
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Test Name'),
              accountEmail: Text('test@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "T",
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      // body: FutureBuilder<List<dynamic>>(
      //   future: ApiService.getFutureData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return new Container(
      //         child: Text("hi rhere"),
      //       );
      //     }
      //     if (snapshot.hasError) {}
      //     return new Center(child: new CircularProgressIndicator());
      //   },
      // ),
      // body: new GridView.count(
      //   crossAxisCount: 2,
      //   children: ApiViewmodel.newPostList.length != 0
      //       ? new List<Widget>.generate(ApiViewmodel.newPostList.length,
      //           (index) {
      //           return new GridTile(
      //               child: new Card(
      //                   color: Colors.blue.shade200,
      //                   child: Row(children: [
      //                     Expanded(
      //                       flex: 2,
      //                       child: new Text(
      //                           ApiViewmodel.newPostList[index].title),
      //                     ),
      //                     IconButton(onPressed: () {}, icon: Icon(Icons.edit))
      //                   ])));
      //         })
      //       : List<Widget>.generate(1, (index) {
      //           return new Center(
      //             child: Text(
      //               "No Data found !",
      //               style: TextStyle(color: Colors.black),
      //             ),
      //           );
      //         }),
      // )
    );
  }
}
