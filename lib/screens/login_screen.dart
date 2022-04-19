// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, unused_field, prefer_typing_uninitialized_variables, unused_local_variable, empty_catches

import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    child: Image(
                      height: 200,
                      image: AssetImage("images/logo.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                decoration: kTextFielDecoration.copyWith(
                  labelText: "Enter your email",
                  hintText: "Enter your email",
                ),
                onChanged: (value) {
                  // print(value);
                  email = value;
                },
                autofocus: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                decoration: kTextFielDecoration.copyWith(
                  labelText: "Enter your password",
                  hintText: "Enter your password",
                ),
                onChanged: (value) {
                  // print(value);
                  password = value;
                },
                autofocus: true,
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    minWidth: 200,
                    height: 42,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final existingUser =
                            await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (existingUser != null) {
                          Navigator.pushNamed(
                            context,
                            ChatScreen.id,
                          );
                          print("Log In Success");
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        print("MyError:  $e");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
