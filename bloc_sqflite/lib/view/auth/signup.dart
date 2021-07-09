import 'package:bloc_sqflite/helper/helper_widget.dart' as helper;
import 'package:bloc_sqflite/services/firebase_service.dart';
import 'package:bloc_sqflite/view/auth/email_login.dart';
import 'package:bloc_sqflite/view/auth/email_signup.dart';
import 'package:bloc_sqflite/view/todos/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// ignore: use_key_in_widget_constructors
class SignUp extends StatelessWidget {
  final String title = "Sign Up";

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Meet Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Sign up with Email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    try {
                      await firebaseService.signInwithGoogle();
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           TodoPage(title: "title", uid: value),
                      //     ));

                      // User? result = FirebaseAuth.instance.currentUser;

                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        helper.showErrorAlert(context, e);
                      }
                    }
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: const Text("Log In Using Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailLogIn()),
                      );
                    }))
          ]),
        ));
  }
}
