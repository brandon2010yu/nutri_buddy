
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_breakfast_screen.dart';
import 'package:nutri_buddy/add_dinner_screen.dart';
import 'package:nutri_buddy/add_lunch_screen.dart';
import 'package:nutri_buddy/login_screen.dart';
import 'package:nutri_buddy/macros_screen.dart';
import 'package:nutri_buddy/signup_screen.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'breakfast_list_view.dart';
import 'dinner_list_view.dart';
import 'goals_screen.dart';
import 'lunch_list_view.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var breakfastCalorie;
  var lunchCalorie;
  var dinnerCalorie;
  var goalObject;
  var breakfastC = 0;
  var lunchC = 0;
  var dinnerC = 0;

  _HomeScreenState(){
    FirebaseDatabase.instance.reference().child("goals").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      print(datasnapshot.value);
      var breakfastTmpList = [];

      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        print(k);

        goalObject = breakfastTmpList;

        setState(() {

        });
      });
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });
    FirebaseDatabase.instance.reference().child("breakfast").once().then((datasnapshot)
    {
      print("Successfully loaded data");





      datasnapshot.value.forEach((k,v)
      {


        breakfastC += int.tryParse(v['Calorie'])!;




        setState(() {

        });
      });

      print(breakfastC);
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });
    FirebaseDatabase.instance.reference().child("lunch").once().then((datasnapshot)
    {
      print("Successfully loaded data");





      datasnapshot.value.forEach((k,v)
      {
        lunchC += int.tryParse(v['Calorie'])!;

        setState(() {

        });
      });
      print(lunchC);
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });
    FirebaseDatabase.instance.reference().child("dinner").once().then((datasnapshot)
    {
      print("Successfully loaded data");





      datasnapshot.value.forEach((k,v)
      {
        dinnerC += int.tryParse(v['Calorie'])!;
        setState(() {

        });
      });
      print(dinnerC);
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
          Column(
            children: [


              Expanded(
                flex:10,
                child: Row(
                  children: [
                    Expanded(child: Text("Total Calories")),
                    Expanded(child: Text("Calories consumed")),
                    Expanded(child: Text("Calories Left")),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(child: Container(
                        margin: EdgeInsets.only(),
                        child: Text("${(goalObject == null ? "" : goalObject[0]['Calorie'])}",style: TextStyle(fontSize: 30),))),
                    Expanded(child: Text(" - ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("${breakfastC + lunchC + dinnerC}", style: TextStyle(fontSize: 30),)),
                    Expanded(child: Text(" = ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("${(goalObject == null ? "" : int.tryParse(goalObject[0]['Calorie'])! - (breakfastC + lunchC + dinnerC))}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                  ],
                ),
              ),
              Expanded(
                flex: 80,
                child: Column(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Row(
                        children: [

                          Expanded(
                            flex: 85,
                            child: Column(

                              children: [

                                Container(
                                  margin: EdgeInsets.only(top:30),
                                  child: FlatButton(
                                    textColor: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BreakfastListView()),
                                      );
                                    },
                                    child: Text("BREAKFAST", style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                                    ),),
                                    shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                                  ),
                                ),

                              ],
                            ),
                          ),




                        ],

                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 85,
                            child: Container(
                                margin: EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top:10),
                                      child: FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => LunchListView()),
                                          );
                                        },
                                        child: Text("LUNCH", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
                                        ),),
                                        shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          ),



                        ],

                      ),
                    ),
                    Expanded(
                      flex: 28,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 85,
                            child: Container(
                                margin: EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    FlatButton(
                                      textColor: Colors.black,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DinnerListView()),
                                        );
                                      },
                                      child: Text("DINNER", style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                                      ),),
                                      shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                                    ),

                                  ],
                                )
                            ),
                          ),



                        ],

                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.deepPurpleAccent,
                  child: Row(
                        children: [
                          Expanded(child: IconButton(
                            highlightColor: Colors.white,
                            hoverColor: Colors.white,
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },icon: Icon(Icons.home),)),
                          Expanded(child: IconButton(
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GoalsScreen()),
                            );
                          },icon: Icon(Icons.wine_bar_sharp),)),
                          Expanded(child: IconButton(
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WorkoutScreen()),
                            );
                          },icon: Icon(Icons.whatshot),)),
                          Expanded(child: IconButton(
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MacrosScreen()),
                            );
                          },icon: Icon(Icons.workspaces_filled),)),


                        ],

                  ),
                )
              )

            ],

          ),
        ],
      ),

    );
  }
}
