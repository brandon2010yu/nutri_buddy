import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/workout_screen.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  var mondayController = TextEditingController();
  var tuesdayController = TextEditingController();
  var wednesdayController = TextEditingController();
  var thursdayController = TextEditingController();
  var fridayController = TextEditingController();
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
                            Text("MONDAY",style: TextStyle(fontStyle: FontStyle.italic,decoration:TextDecoration.underline),),
                            Container(
                              width: 350,
                              child: TextField(
                                controller: mondayController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Monday Workout',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("TUESDAY",style: TextStyle(fontStyle: FontStyle.italic,decoration: TextDecoration.underline),),
                            Container(
                              width: 350,
                              child: TextField(
                                controller: tuesdayController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tuesday Workout',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("WEDNESDAY",style: TextStyle(fontStyle: FontStyle.italic,decoration:TextDecoration.underline),),
                            Container(
                              width: 350,
                              child: TextField(
                                controller: wednesdayController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Wednesday Workout',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("THURSDAY",style: TextStyle(fontStyle: FontStyle.italic,decoration:TextDecoration.underline),),
                            Container(
                              width: 350,
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
                      Expanded(
                        child: Column(
                          children: [
                            Text("FRIDAY",style: TextStyle(fontStyle: FontStyle.italic,decoration: TextDecoration.underline),),
                            Container(
                              width: 350,
                              child: TextField(
                                controller: fridayController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Friday Workout',
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
                    FirebaseDatabase.instance.reference().child("workout/w" + timestamp.toString()).set(
                        {
                          "Monday": mondayController.text,
                          "Tuesday": tuesdayController.text,
                          "Wednesday": wednesdayController.text,
                          "Thursday": thursdayController.text,
                          "Friday": fridayController.text,

                        }).then((value) {
                      print("Successfully planned workout");
                    }).catchError((error){
                      print("Failed to add. " + error.toString());


                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutScreen()),
                    );
                  }, child: Text("Plan Workout")),
                )

              ],

            ),
          ),
        ],
      ),
    );
  }
}
