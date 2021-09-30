import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_breakfast_screen.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'goals_screen.dart';
import 'home_screen.dart';
import 'macros_screen.dart';

class BreakfastListView extends StatefulWidget {
  const BreakfastListView({Key? key}) : super(key: key);

  @override
  _BreakfastListViewState createState() => _BreakfastListViewState();
}

class _BreakfastListViewState extends State<BreakfastListView> {

  var foodList = [];



  _BreakfastListViewState() {
      refreshBreakfastList();
      FirebaseDatabase.instance.reference().child("breakfast").onChildChanged.listen((event) {
        print("data changed");
        refreshBreakfastList();
    });
  }

  void refreshBreakfastList(){
    FirebaseDatabase.instance.reference().child("breakfast").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      var breakfastTmpList = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        foodList = breakfastTmpList;
        setState(() {

        });
      });
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });


  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                      image: AssetImage("assets/home.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop)
                  )
              )
          ),
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: foodList.length,
                itemBuilder: (BuildContext context,int index){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(

                            child: Text("Name: ",style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic),)),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                            child: Text('${foodList[index]['Name']}',
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),

                          Text("Calories: ",style: TextStyle(fontSize: 30),),
                        Container(
                            child: Text('${foodList[index]['Calorie']}',style: TextStyle(
                              fontSize: 30,fontWeight: FontWeight.bold
                            ),))
                      ],
                    ),
                  );

                }),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 52, left: 20),
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 56,
              width: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),

                ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }, child: Icon(Icons.home)),
            ),
          )
        ],
      ),



      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom:40),
        child: FloatingActionButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBreakfastScreen()),
              );
            }, child: Icon(Icons.add)),
      ),





    );
  }
}
