import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_workout_screen.dart';
import 'package:nutri_buddy/friday_list_view.dart';
import 'package:nutri_buddy/monday_list_view.dart';
import 'package:nutri_buddy/thursday_list_view.dart';
import 'package:nutri_buddy/tuesday_list_view.dart';
import 'package:nutri_buddy/wednesday_list_view.dart';

import 'add_monday_workout.dart';
import 'goals_screen.dart';
import 'home_screen.dart';
import 'macros_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                      image: AssetImage("assets/workout.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop)
                  )
              )
          ),
          Center(
            child: Column(
              children: [
                Expanded(
                  flex: 14,
                    child: Container(
                      margin: EdgeInsets.only(top:20),
                        child: Text("Workout Planner",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)
                    )
                ),
                Expanded(
                  flex: 82,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(

                          children: [
                            Container(

                                child: FlatButton(
                            textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MondayListView()),
                      );
                    },
                    child: Text("MONDAY", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                    ),),
                    shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                  ),
                            )


                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TuesdayListView()),
                                );
                              },
                              child: Text("TUESDAY", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                              ),),
                              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WednesdayListView()),
                                );
                              },
                              child: Text("WEDNESDAY", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                              ),),
                              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ThursdayListView()),
                                );
                              },
                              child: Text("THURSDAY", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                              ),),
                              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            FlatButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FridayListView()),
                                );
                              },
                              child: Text("FRIDAY", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                              ),),
                              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                            ),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),


                Expanded(
                    flex: 9,
                    child: Container(
                      color: Colors.deepPurpleAccent,
                      child: Row(
                        children: [
                          Expanded(child: IconButton(
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
          ),
        ],
      ),
    );
  }
}
