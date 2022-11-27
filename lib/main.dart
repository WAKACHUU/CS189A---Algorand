import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/login/login_page.dart';
import 'package:algo_learn/signup/signup.dart';
import 'package:algo_learn/home/home.dart';
import 'package:algo_learn/profile/profile.dart';
import 'package:algo_learn/courses/course_page.dart';
import 'package:algo_learn/wallet/wallet.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  // ensure the database is connected
  WidgetsFlutterBinding.ensureInitialized();
  // var Firebase;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // intialize the widgets
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Algo-learn',
      initialRoute: '/login',
      // home: Mainpage(),
      routes: {
        '/login': (context) => LoginDemo(),
        '/signup': (context) => SignUpDemo(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
         '/courses': (context) => CoursePage(),
         '/wallet': (context) => WalletPage(),
      }
    );
  }

}


// class Mainpage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//             return HomePage();
//         } else {
//           return LoginDemo();
//         }
//       },
//     )
//   );
// }