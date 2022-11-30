import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:algo_learn/profile/profile.dart';
// import 'package:googleapis/healthcare/v1.dart';
// import 'package:googleapis/adsense/v2.dart';
// import 'package:googleapis/content/v2_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;
  int _index=0;
  String username='aaaa';
  String email = "aaaa";


  Future<String> get_user_info() async{
    email= FirebaseAuth.instance.currentUser!.email.toString();
    
    await FirebaseFirestore.instance.collection('login').get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if(doc['email']==email){
          username = doc['name']!;
        }
      })
    });
    return username;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user_info().then((value) => setState(() {username = value;}));
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child:Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButton: floatingActionButton(),
      appBar:AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                //todo
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
          title: Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'HOME',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      )
              ),
        ),
        body:SingleChildScrollView(
        child:Column(
          children: [
            Container(
                      color: Colors.white,
                      child: Padding(
                        padding:const EdgeInsets.all(20.0) ,
                        child: 
                          TextFormField(
                            onTap: (){},
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        ),
                  ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children:[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage: AssetImage('asset/images/cat.jpeg'),
                          ),
                          InkWell(
                            onTap:(){},
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.edit,color: Colors.white),
                            )
                          )
                        ]
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          email,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child:Text(
                                username,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                      )
                    ],
                  ),
                
                ],)
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child:              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Text(
                          'Quarters',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                  ),
                  Row(
                    children:[
                      menuButton(
                        color:_index==0?Colors.blue:Colors.grey.shade300,
                        text:'Fall 2022',
                        textColor:_index==0? Colors.white:Colors.black,
                        width: width,
                        onTap: (){
                          setState(() {
                            _index=0;
                          });
                        }),
                      menuButton(
                        color:_index==1?Colors.blue:Colors.grey.shade300,
                        text:'Spring 2022',
                        textColor:_index==1? Colors.white:Colors.black,
                        width: width,
                        onTap: (){
                          setState(() {
                            _index=1;
                          });
                        }), 
                      menuButton(
                        color:_index==2?Colors.blue:Colors.grey.shade300,
                        text:'Summer 2022',
                        textColor:_index==2? Colors.white:Colors.black,
                        width: width,
                        onTap: (){
                          setState(() {
                            _index=2;
                          });
                        }),
                    ]
                  ),
      
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Text(
                          'Courses',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                  ), 
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(mainAxisSize: MainAxisSize.max,
                    children: [
                      courseButton(name: "CS189A", description: "Capstone project", nftOwned: "7 nft owned", width: width, height: height),
                      courseButton(name: 'CS165A', description: "Intro to AI", nftOwned: "10 nft owned", width: width, height: height),
                      courseButton(name: "CS181", description: "Computer Vision", nftOwned: "5 nft owned", width: width, height: height),
                      courseButton(name: 'CS160', description: 'Transfer to compiling language', nftOwned: '6 nftOwned', width: width, height: height)
                    ],
                                  ),
                  ),
                  ],
                )
                
                 
                ],

              
              ),
            
              )  
        ])
          
          
    )));
        // )
  }
  
  bottomNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (int index){
        setState(() {
          if(index == 0){
            Navigator.of(context).pushReplacementNamed('/home');
          }
          else if(index == 1){
            Navigator.of(context).pushNamed('/courses');
          }
          else if(index == 2){
            Navigator.of(context).pushNamed('/profile');
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
  
  floatingActionButton()
  {
    return FloatingActionButton(
      onPressed: (){},
      elevation: 0,
      child: Icon(Icons.qr_code_scanner,
      size: 30,),
      backgroundColor: Colors.blue,
    );
  }

  menuButton({required String text, required Color color, required Color textColor, required double width, required VoidCallback onTap})
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width/8,
          height:45, 
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text(text,style: TextStyle(
                              fontSize: 12*width/800,
                              color:textColor,
                              fontWeight: FontWeight.bold,
                            ),),
        
        ),
      )
    );
  }

  courseButton({required String name, required String description, required String nftOwned, required double width, required double height })
  {
    return InkWell(
      onTap:(){
        //todo
      },
      child:Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                        
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Container(
                            height: height/8,
                            width: width/3.5,
                            decoration:  BoxDecoration(
                              color: Colors.grey.shade300,
                              // border: Border.
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(name, style: TextStyle(fontSize: 24*width/1000, color: Colors.black,fontWeight:FontWeight.bold ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(description, style: TextStyle(fontSize: 15*width/900, color: Colors.black, overflow: TextOverflow.ellipsis),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: (width/3.5),
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
                            child: Text(nftOwned, style: TextStyle(fontSize: 12, color: Colors.white)),
                          ),
                        ),
                      ],
                    ));
  }
  
  
}