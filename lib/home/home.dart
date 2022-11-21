import 'package:flutter/material.dart';

import 'package:untitled1/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Widget> widgets = [];
  // void tmp() async {
  //   var data = await id.get();
  //   var map = data.value as Map;

  //   if (map.length > 5) {
  //     for (var i = map.length - 1; i > map.length - 6; i--) {
  //       Icon icon = IconTypeMapping()
  //           .mapTypeToIcon(map.values.elementAt(i)['type'].toString());
  //       // print(map.values.elementAt(i)['amount']);
  //       Widget temp = Padding(
  //         padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
  //         child: Container(
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.black, width: 1),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 10.0),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black, width: 1),
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: icon,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 5.0),
  //                             child: Text(
  //                               map.values.elementAt(i)['type'].toString(),
  //                               style: TextStyle(
  //                                   fontSize: 20, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 20.0),
  //                             child: Text(
  //                               map.values.elementAt(i)['date'].toString(),
  //                               style: TextStyle(
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.normal),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 10.0, top: 5, bottom: 5),
  //                         child: Text(
  //                           map.values.elementAt(i)['note'].toString(),
  //                           style: TextStyle(fontSize: 16),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(child: Container()),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
  //                   child: Text(
  //                     map.values.elementAt(i)['amount'].toString(),
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       );
  //       widgets.add(temp);
  //     }
  //   } else {
  //     for (var i = 0; i < map.length; i++) {
  //       Icon icon = IconTypeMapping()
  //           .mapTypeToIcon(map.values.elementAt(i)['type'].toString());
  //       Widget temp = Padding(
  //         padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
  //         child: Container(
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.black, width: 1),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 10.0),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.black, width: 1),
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: icon,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 5.0),
  //                             child: Text(
  //                               map.values.elementAt(i)['type'].toString(),
  //                               style: TextStyle(
  //                                   fontSize: 20, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 20.0),
  //                             child: Text(
  //                               map.values.elementAt(i)['date'].toString(),
  //                               style: TextStyle(
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.normal),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             left: 10.0, top: 5, bottom: 5),
  //                         child: Text(
  //                           map.values.elementAt(i)['note'].toString(),
  //                           style: TextStyle(fontSize: 16),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(child: Container()),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
  //                   child: Text(
  //                     map.values.elementAt(i)['amount'].toString(),
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       );
  //       widgets.add(temp);
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'HOME',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox.fromSize(
                    size: const Size(60, 60),
                    child: ClipOval(
                      child: Material(
                        color: Color.fromARGB(113, 233, 232, 230),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/home');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.home_filled,
                                color: Colors.black,
                              ), // <-- Icon
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(60, 60),
                    child: ClipOval(
                      child: Material(
                        color: Color.fromARGB(113, 233, 232, 230),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/courses');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.person), // <-- Icon
                              Text(
                                "Courses",
                                style: TextStyle(fontSize: 14),
                              ), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(60, 60),
                    child: ClipOval(
                      child: Material(
                        color: Color.fromARGB(113, 233, 232, 230),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/profile');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.person), // <-- Icon
                              Text(
                                "Profile",
                                style: TextStyle(fontSize: 14),
                              ), // <-- Text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}