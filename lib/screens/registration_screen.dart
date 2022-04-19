// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_print, avoid_unnecessary_containers, unused_field, prefer_typing_uninitialized_variables, import_of_legacy_library_into_null_safe, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFielDecoration.copyWith(
                  labelText: "Enter your email",
                  hintText: "Enter your email",
                ),
                onChanged: (value) {
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
                    hintText: "Enter your password"),
                onChanged: (value) {
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
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    minWidth: 200,
                    height: 42,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // print(email);
                      // print(password);
                      setState(() {
                          showSpinner = true;
                      });
                      try {
                        
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (newUser != null) {
                          Navigator.pushNamed(
                            context,
                            ChatScreen.id,
                          );
                          print("Registration Success");
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
