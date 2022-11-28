import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:algo_learn/profile/profile.dart';
import 'package:googleapis/healthcare/v1.dart';
// import 'package:googleapis/adsense/v2.dart';
// import 'package:googleapis/content/v2_1.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;
  int _index=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
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
              padding: const EdgeInsets.only(top: 20),
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
                          'email',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child:Text(
                                'User Name',
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
                        color:_index==0?Colors.blue:Colors.grey,
                        text:'Fall 2022',
                        textColor:_index==0? Colors.white:Colors.black,
                        width: 85,
                        onTap: (){
                          setState(() {
                            _index=0;
                          });
                        }),
                      menuButton(
                        color:_index==1?Colors.blue:Colors.grey,
                        text:'Spring 2022',
                        textColor:_index==1? Colors.white:Colors.black,
                        width: 85,
                        onTap: (){
                          setState(() {
                            _index=1;
                          });
                        }), 
                      menuButton(
                        color:_index==2?Colors.blue:Colors.grey,
                        text:'Summer 2022',
                        textColor:_index==2? Colors.white:Colors.black,
                        width: 85,
                        onTap: (){
                          setState(() {
                            _index=2;
                          });
                        }),
                    ]
                  ),
      
                  
                 
                ]
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
          width: width,
          height:45, 
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text(text,style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
        
        ),
      )
    );
  }
  
  
}