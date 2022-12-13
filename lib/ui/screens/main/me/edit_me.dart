import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:algo_learn/models/me_page_model/user.dart';
import 'package:algo_learn/ui/screens/main/me/edit_me.dart';
import 'package:algo_learn/utils/me_util/user_preferences.dart';
import 'package:algo_learn/utils/widget/appbar_widget.dart';
import 'package:algo_learn/utils/widget/button_widget.dart';
import 'package:algo_learn/utils/widget/numbers_widget.dart';
import 'package:algo_learn/utils/widget/profile_widget.dart';
import '../../../../utils/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // User user = UserPreferences.myUser;

  String username = 'xxx';
  String email = "xxx";
  String about="xxx";

  // int _selected_index = 0;
  // static const option_style = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selected_index = index;
  //   });
  // }

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
    print(email);
    print(username);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                ProfileWidget(
                  imagePath: "https://pbs.twimg.com/profile_images/1336703991124815907/FQIgoIHT_400x400.png",
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: username,
                  onChanged: (name) {},
                ),
                // const SizedBox(height: 24),
                // TextFieldWidget(
                //   label: 'Email',
                //   text: email,
                //   onChanged: (email) {},
                // ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Description',
                  text: about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
                const SizedBox(height: 10),
                
              ],
            ),
          ),
        ),
      );
}