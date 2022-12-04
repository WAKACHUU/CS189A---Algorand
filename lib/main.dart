import 'package:algo_learn/courses/course_page.dart';
import 'package:algo_learn/home/home.dart';
import 'package:algo_learn/login/login_page.dart';
import 'package:algo_learn/signup/signup.dart';
import 'package:algo_learn/ui/screens/main/profile/profile.dart';
import 'package:algo_learn/ui/screens/main/wallets/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/database/entities.dart';
import 'package:algo_learn/database/entities/account_entity.dart';
import 'package:algo_learn/routes/routes.dart';
import 'package:algo_learn/theme/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:algo_learn/login/login_page.dart';
// import 'package:algo_learn/signup/signup.dart';
// import 'package:algo_learn/home/home.dart';
import 'package:algo_learn/profile/profile.dart';
// import 'package:algo_learn/courses/course_page.dart';
// import 'package:algo_learn/wallet/wallet.dart';
import 'package:algo_learn/ui/screens/screens.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:algo_learn/ui/screens/main/dashboard/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //   // var Firebase;
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
      title: 'Algo-learn',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initialRoute,
      // routes: {
        // '/': (context) => const MainScreen(),
        // '/login': (context) => LoginDemo(),
        // '/signup': (context) => SignUpDemo(),
        // '/home': (context) =>  HomePage(),
        // '/me': (context) =>  MePage(),
        // '/courses': (context) => CoursePage(),
        // '/wallet': (context) => WalletPage(),
        // '/mainScreen': (context) => MainScreen(),
        // '/dashboard': (context) => DashboardPage(),
      // },
      onGenerateRoute: router.generator,
    );
  }
}
