import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:algo_learn/login/login_page.dart';
// import 'package:algo_learn/signup/signup.dart';
// import 'package:algo_learn/home/home.dart';
// import 'package:algo_learn/profile/profile.dart';
// import 'package:algo_learn/courses/course_page.dart';
// import 'package:algo_learn/wallet/wallet.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() async{
//   // ensure the database is connected
//   WidgetsFlutterBinding.ensureInitialized();
//   // var Firebase;
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // intialize the widgets
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Algo-learn',
//       initialRoute: '/login',
//       // home: Mainpage(),
//       routes: {
//         '/login': (context) => LoginDemo(),
//         '/signup': (context) => SignUpDemo(),
//         '/home': (context) => HomePage(),
//         '/profile': (context) => ProfilePage(),
//          '/courses': (context) => CoursePage(),
//          '/wallet': (context) => WalletPage(),
//       }
//     );
//   }

// }

import 'package:flutter/material.dart';
import 'package:algo_learn/database/entities.dart';
import 'package:algo_learn/database/entities/account_entity.dart';
import 'package:algo_learn/routes/routes.dart';
import 'package:algo_learn/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(AlgorandStandardAssetAdapter());
  Hive.registerAdapter(AccountAdapter());

  await Hive.openBox<AccountEntity>('accounts');
  await Hive.openBox<AlgorandStandardAssetEntity>('assets');

  // Register the service locator and dependencies
  await ServiceLocator.register();

  // Register the account repository
  await accountRepository.init();

  // Register the routing
  await RouteConfiguration.register();

  final routeName = '/'; //MainScreen.routeName;

  // Run the app
  runApp(AlgorandWallet(initialRoute: routeName));
}

class AlgorandWallet extends StatelessWidget {
  final String initialRoute;

  AlgorandWallet({
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algorand Wallet',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initialRoute,
      onGenerateRoute: router.generator,
    );
    
  }
}