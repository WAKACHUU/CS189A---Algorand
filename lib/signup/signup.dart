// login Page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:algo_learn/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'HomePage.dart';

import 'package:algorand_dart/algorand_dart.dart';


class SignUpDemo extends StatefulWidget {
  @override
  _SignUpDemoState createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUpDemo> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Image.asset(
              'asset/images/algorand.png',
              fit: BoxFit.fitHeight,
              height: 64,
            )),
            // Expanded(
            //     child: Container(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text('Algo-learn Learning Management-system'))),
            Expanded(
                child: Center(
                    child: Container(
                        padding: const EdgeInsets.only(right:125),
                        child: Text(
                          'Algo-Learn LMS',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    )
            )
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/UCSB.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userNameController,
                key: Key('name'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter your full name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                obscureText: false,
                key: Key('email'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    hintText:
                        'Enter valid email address, for instance: abc@ucsb.edu'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                key: Key('password'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                key: Key('confirmPassword'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter password'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  // check whether the email is already in the firestore database document
                  // var write=true;
                  var found = false;
                  await FirebaseFirestore.instance
                      .collection('login')
                      .get()
                      .then((QuerySnapshot querySnapshot) => {
                            querySnapshot.docs.forEach((doc) {
                              if (doc['email'] == emailController.text) {
                                found = true;
                              }
                            })
                          });
                  if (found == true) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('The email is already registered')));
                    });
                  } else if (!emailController.text.endsWith('ucsb.edu')) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('The email is not ended with ucsb.edu')));
                    });
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('The password is not matched')));
                    });
                  } else if (found == false) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      // final account=await Algorand.createAccount();

                      // add document to firestore database
                      FirebaseFirestore.instance.collection('login').add({
                        'name': userNameController.text,
                        'email': emailController.text,
                        //'password': passwordController.text,                        
                      }).then((value) {
                        print('User Added');
                        Navigator.of(context).pop();
                      }).catchError((onError) {
                        print(onError);
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'The password provided is too weak, at least 6 characters')));
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
