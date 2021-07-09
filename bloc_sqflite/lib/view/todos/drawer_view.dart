import 'package:bloc_sqflite/view/auth/signup.dart';
import 'package:bloc_sqflite/view/todos/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NavigateDrawer extends StatefulWidget {
  final String uid;
  const NavigateDrawer({Key? key, required this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("Dummy Name"),
            accountEmail: FutureBuilder(
              future: FirebaseDatabase.instance
                  .reference()
                  .child("Users")
                  .child(widget.uid)
                  .once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.value['email']);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading:
                IconButton(onPressed: () => {}, icon: const Icon(Icons.home)),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoPage(
                            title: 'title',
                            uid: widget.uid,
                          )));
            },
          ),
          ListTile(
            leading:
                IconButton(onPressed: () => {}, icon: const Icon(Icons.logout)),
            title: const Text("Logout"),
            onTap: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
    );
  }
}
