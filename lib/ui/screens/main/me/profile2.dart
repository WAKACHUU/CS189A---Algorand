import 'package:algo_learn/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:algo_learn/ui/screens/main/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:googleapis/admin/directory_v1.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:googleapis/cloudsearch/v1.dart';
import 'package:algo_learn/theme/themes.dart';

class MePage2 extends StatefulWidget {
  const MePage2({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage2> with TickerProviderStateMixin {
  // var width = MediaQuery.of(context).size.width;
  // var height = MediaQuery.of(context).size.height;

  String username = 'aaaa';
  String email = "aaaa";

  // todo
  String algoAddress = "todo";
  late TabController _tabController;

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

  Future<String> get_user_info() async {
    email = FirebaseAuth.instance.currentUser!.email.toString();

    await FirebaseFirestore.instance
        .collection('login')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc['email'] == email) {
                  username = doc['name']!;
                }
              })
            });
    return username;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    get_user_info().then((value) => setState(() {
          username = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    color: Colors.transparent,
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                color: Colors.transparent,
                              ),
                              Text(
                                username,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                algoAddress,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      child: TabBar(
                                        indicatorColor: Colors.black,
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.grey,
                                        tabs: [
                                          Tab(text: "My Wallet"),
                                          Tab(text: "Collection"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        // controller: _tabController,
                                        children: [
                                          Center(
                                            child: Text("It's cloudy here"),
                                          ),
                                          Center(
                                            child: Text("It's rainy here"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
              // Profile image
              Positioned(
                top: 25.0, // (background container size) - (circle height / 2)
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://pbs.twimg.com/profile_images/1336703991124815907/FQIgoIHT_400x400.png"),
                    radius: 60.0,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
