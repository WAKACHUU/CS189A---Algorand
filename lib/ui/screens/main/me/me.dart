import 'package:algo_learn/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/ui/screens/main/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:googleapis/admin/directory_v1.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:googleapis/cloudsearch/v1.dart';
import 'package:algo_learn/theme/themes.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/models/me_page_model/user.dart';
import 'package:algo_learn/ui/screens/main/me/edit_me.dart';
import 'package:algo_learn/utils/me_util/user_preferences.dart';
import 'package:algo_learn/utils/widget/appbar_widget.dart';
import 'package:algo_learn/utils/widget/button_widget.dart';
import 'package:algo_learn/utils/widget/numbers_widget.dart';
import 'package:algo_learn/utils/widget/profile_widget.dart';


class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  // var width = MediaQuery.of(context).size.width;
  // var height = MediaQuery.of(context).size.height;

  String username = 'xxx';
  String email = "xxx";
  String about="xxx";

  int _selected_index = 0;
  static const option_style = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  Future<List<String>> get_user_info() async {
    email = FirebaseAuth.instance.currentUser!.email.toString();

    await FirebaseFirestore.instance
        .collection('login')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc['email'] == email) {
                  username = doc['name']!;
                  about=doc['description'];
                }
              })
            });
    return [username,about];
  }

  @override
  void initState() {
    super.initState();
    get_user_info().then((value) => setState(() {
          username = value[0];
          about=value[1];
        }));
  }


    @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;

    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              ProfileWidget(
                imagePath: "https://pbs.twimg.com/profile_images/1336703991124815907/FQIgoIHT_400x400.png",
                onClicked: () {
                  Navigator.of(context).pushNamed('/me/edit');
                },
              ),
              const SizedBox(height: 24),
              buildName(this.username,this.email),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAbout(this.about),
            ],
          ),
        ),
      ),
    );
  }

   Widget buildName(String username,String email) => Column(
        children: [
          Text(
            username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Block Chain',
        // color: Palette.accentColor,
        onClicked: () {
          Navigator.pushNamed(context, '/mainScreen');},
      );

  

  Widget buildAbout(String about) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //         backgroundColor: Palette.accentColor,
  //         title: Text(
  //           'Profile',
  //           style: TextStyle(
  //             fontSize: 26,
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         leading: IconButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             icon: const Icon(
  //               Icons.arrow_back_ios_new_rounded,
  //               color: Colors.white,
  //             ))),
  //     body: Center(
  //       child: Padding(
  //         // padding: const EdgeInsets.symmetric(horizontal: 20),
  //         padding: EdgeInsets.only(top: 20),
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20.0),
  //               child: Container(
  //                 width: double.infinity,
  //                 height: 200,
  //                 child: Container(
  //                   alignment: Alignment(0.0, 0.5),
  //                   child: CircleAvatar(
  //                     backgroundImage: NetworkImage(
  //                         "https://pbs.twimg.com/profile_images/1336703991124815907/FQIgoIHT_400x400.png"),
  //                     radius: 60.0,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 5.0),
  //               child: Text(
  //                 username,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 10.0, left: 90.0),
  //                     child: Container(
  //                       child: Text(
  //                         "Email: ",
  //                         textAlign: TextAlign.left,
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     )),
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 10.0, right: 70.0),
  //                     child: Container(
  //                       child: Text(
  //                         email,
  //                         textAlign: TextAlign.left,
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     )),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 30.0),
  //                     child: Container(
  //                         alignment: Alignment.center,
  //                         child: OutlinedButton(
  //                           onPressed: () {
  //                             // jump to the wallet page
  //                             Navigator.pushNamed(context, '/wallets');
  //                             // Navigator.push(context, new MaterialPageRoute(
  //                             //   builder: (context) =>
  //                             //     new MainScreen())
  //                             //   );
  //                           },
  //                           child: Text(
  //                             "Wallets",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: OutlinedButton.styleFrom(
  //                             primary: Colors.black,
  //                             side: BorderSide(
  //                               color: Colors.black,
  //                               width: 1,
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                             minimumSize: Size(300, 40),
  //                           ),
  //                         ))),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 30.0),
  //                     child: Container(
  //                         alignment: Alignment.center,
  //                         child: OutlinedButton(
  //                           onPressed: () {
  //                             // jump to the wallet page
  //                             Navigator.pushNamed(context, '/mainScreen');
  //                             // Navigator.push(context, new MaterialPageRoute(
  //                             //   builder: (context) =>
  //                             //     new MainScreen())
  //                             //   );
  //                           },
  //                           child: Text(
  //                             "Block Chain",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: OutlinedButton.styleFrom(
  //                             primary: Colors.black,
  //                             side: BorderSide(
  //                               color: Colors.black,
  //                               width: 1,
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                             minimumSize: Size(300, 40),
  //                           ),
  //                         ))),
  //               ],
  //             ),
  //             // and a button to logout
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 30.0),
  //                     child: Container(
  //                         alignment: Alignment.center,
  //                         child: OutlinedButton(
  //                           onPressed: () async {
  //                             // firebase auth sign out

  //                             await FirebaseAuth.instance.signOut();
  //                             // print(_auth);
  //                             // print('Signed out');
  //                             // navigate to login page and change the route to login page
  //                             Navigator.pushNamedAndRemoveUntil(
  //                                 context, '/', (route) => false);
  //                           },
  //                           child: Text(
  //                             "Logout",
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: OutlinedButton.styleFrom(
  //                             primary: Colors.black,
  //                             side: BorderSide(
  //                               color: Colors.black,
  //                               width: 1,
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                             minimumSize: Size(300, 40),
  //                           ),
  //                         ))),
  //               ],
  //             ),

  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}