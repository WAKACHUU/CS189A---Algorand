// login Page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled1/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/home/home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class LoginDemo extends StatefulWidget {
  // Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage()),
  //         (Route<dynamic> route) => false,
  // );

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginDemo()),
    //         (route) => false,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Image.asset(
              'asset/images/algorand.png',
              fit: BoxFit.fitHeight,
              height: 64,
            )),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Algo-learn Learning Management-system'))),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 115, 179, 239),
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
                controller: emailController,
                key: Key('email-field'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@ucsb.edu'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                key: Key('password-field'),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 115, 179, 239), fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 115, 179, 239),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: signIn,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account'),
            TextButton(
                onPressed: (
                    //TODO SIGNUP SCREEN GOES HERE
                    ) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpDemo()),
                  );
                },
                key: Key('signup'), //for testing
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Color.fromARGB(255, 115, 179, 239), fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    //TODO SIGN IN METHOD GOES HERE
    // check wether the email and password are in the database
    // if yes then navigate to home page
    // else show error message
    var sign = false;
    var account = false;
    await FirebaseFirestore.instance
        .collection('login')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc['email'] == emailController.text.trim() &&
                    doc['password'] == passwordController.text.trim()) {
                  sign = true;
                } else if (doc['password'] != passwordController.text.trim() &&
                    doc['email'] == emailController.text.trim()) {
                  account = true;
                }
              })
            });
    if (sign) {
      // firebase sign in
      // print("sign in");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // print(FirebaseAuth.instance.currentUser);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (account == false) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      });
    } else if (account == true) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      });
    }
  }
}
