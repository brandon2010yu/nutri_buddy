import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'goals_data.dart';
import 'home_screen.dart';
import 'macros_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {

  var calorieController = TextEditingController();
  var proteinController = TextEditingController();
  var carbController = TextEditingController();
  var fatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                      image: AssetImage("assets/goals.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop)
                  )
              )
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("GOALS",
                      style: TextStyle(fontStyle: FontStyle.italic,fontSize: 40,fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Target Calories: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: calorieController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Calories',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Target Protein: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      width: 210,
                      child: TextField(
                        controller: proteinController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Protein',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Target Carbohydrates: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      width: 145,
                      child: TextField(
                        controller: carbController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Carbohydrates',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Target Fats: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      width: 235,
                      child: TextField(
                        controller: fatController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fats',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.only(top:30),
                      child: ElevatedButton(onPressed: (){
                        print(calorieController.text);
                        if(calorieController.text != "" && proteinController.text != "" && carbController.text != "" && fatController.text != "")
                          {
                        FirebaseDatabase.instance.reference().child("goals/g001").set(
                            {
                              "Calorie": calorieController.text,
                              "Protein": proteinController.text,
                              "Carbohydrate": carbController.text,
                              "fat": fatController.text,
                            }).then((value) {
                          print("Successfully added Goal");
                        }).catchError((error){
                          print("Failed to add. " + error.toString());


                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                        }
                      }, child: Text("Set Goal")),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top:40),
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
