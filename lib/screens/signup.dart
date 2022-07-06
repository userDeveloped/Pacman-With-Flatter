import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacman_beta/screens/signin.dart';


import '../colors.dart';
import '../reusableWidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseFirestore store = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                StringToColor("000779"),
                StringToColor("9546C4"),
                StringToColor("000779")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/logo.png" ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    signInSignUpButton(context, false, (){
                      //users.add({'email': _emailTextController.text, 'score': 0}).then((value) => print(value.id));
                      //store.collection("Users").doc(_emailTextController.text).set({"score":0});

                      FirebaseFirestore.instance.collection('Users').doc(_emailTextController.text).set({
                        'score' : 0
                        });

                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text).
                      then((value)
                      {

                      Navigator.push(context,
                      MaterialPageRoute(builder:  (context) => SignInScreen()));
                      }).onError((error, stackTrace) {
                        print("error ${error.toString()}");
                        showAlertDialog(context);
                      })
                      ;
                      //String temp = FirebaseAuth.instance.currentUser!.email.toString();




                    })
                  ],
                ),
              ))),
    );
  }

  showAlertDialog(BuildContext context) {

    //  set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Password should be at least 6 characters"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return alert;

      },
    );
  }
}