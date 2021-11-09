import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'home_screen.dart';

class AddThursdayWorkout extends StatefulWidget {
  const AddThursdayWorkout({Key? key}) : super(key: key);

  @override
  _AddThursdayWorkoutState createState() => _AddThursdayWorkoutState();
}

class _AddThursdayWorkoutState extends State<AddThursdayWorkout> {
  var thursdayController = TextEditingController();
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
                    flex: 10,
                    child: Container(
                        margin: EdgeInsets.only(top:20),
                        child: Text("Workout Planner",style: TextStyle(fontSize: 40,fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,decoration: TextDecoration.underline),))),
                Expanded(
                  flex: 82,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Text("THURSDAY",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,fontStyle: FontStyle.italic,decoration:TextDecoration.underline),)),
                            Container(
                              margin: EdgeInsets.only(top:100),
                              width: 350,
                              height: 300,
                              child: TextField(
                                controller: thursdayController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Thursday Workout',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.only(bottom:10),
                  child: ElevatedButton(onPressed: (){

                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    if(thursdayController.text != "") {
                      FirebaseDatabase.instance.reference().child(uid.toString() +
                          "/thursdayworkout/w" + timestamp.toString()).set(
                          {
                            "Thursday": thursdayController.text,


                          }).then((value) {
                        print("Successfully planned workout");
                      }).catchError((error) {
                        print("Failed to add. " + error.toString());
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            WorkoutScreen()),
                      );
                    }
                  }, child: Text("Plan Workout")),
                )

              ],

            ),
          ),
        ],
      ),
      floatingActionButton: Container(

          child: FloatingActionButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutScreen()),
            );
          },child: Icon(Icons.whatshot))),

    );
  }
}
