import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddDinnerScreen extends StatefulWidget {
  const AddDinnerScreen({Key? key}) : super(key: key);

  @override
  _AddDinnerScreenState createState() => _AddDinnerScreenState();
}

class _AddDinnerScreenState extends State<AddDinnerScreen> {
  var nameController = TextEditingController();
  var proteinController = TextEditingController();
  var carbController = TextEditingController();
  var fatController = TextEditingController();
  var calorieController = TextEditingController();
  var weightController = TextEditingController();

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
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20),
                  child: Text("Add Dinner",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 40,fontWeight: FontWeight.bold, decoration:
                    TextDecoration.underline),),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Name of Food: "),
                            Container(
                              width: 200,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Food Name',
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
                            Text("Protein: "),
                            Container(
                              width: 240,
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
                            Text("Carbohydrates: "),
                            Container(
                              width: 190,
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
                            Text("Fat: "),
                            Container(
                              width: 260,
                              child: TextField(
                                controller: fatController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Fat',
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
                            Text("Total calories: "),
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
                            Text("Weight of food: "),
                            Container(
                              width: 190,
                              child: TextField(
                                controller: weightController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Weight',
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  margin: EdgeInsets.only(bottom:10),
                  child: ElevatedButton(onPressed: (){
                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    if(nameController.text != "" && calorieController.text != "") {
                      FirebaseDatabase.instance.reference().child(
                          "dinner/d" + timestamp.toString()).set(
                          {
                            "Name": nameController.text,
                            "Protein": proteinController.text,
                            "Carbohydrate": carbController.text,
                            "fat": fatController.text,
                            "Calorie": calorieController.text,
                            "Weight": weightController.text,
                          }).then((value) {
                        print("Successfully added dinner item");
                      }).catchError((error) {
                        print("Failed to add. " + error.toString());
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  }, child: Text("Add Food")),
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
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },child: Icon(Icons.home))),
    );
  }
}
