import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_friday_workout.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'home_screen.dart';

class FridayListView extends StatefulWidget {
  const FridayListView({Key? key}) : super(key: key);

  @override
  _FridayListViewState createState() => _FridayListViewState();
}

class _FridayListViewState extends State<FridayListView> {


  var fridayList = [];

  _FridayListViewState() {
    refreshBreakfastList();
    FirebaseDatabase.instance.reference().child("fridayworkout").onChildChanged.listen((event) {
      print("data changed");
      refreshBreakfastList();
    });
  }

  void refreshBreakfastList(){
    FirebaseDatabase.instance.reference().child("fridayworkout").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      var breakfastTmpList = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        fridayList = breakfastTmpList;
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
                      image: AssetImage("assets/workout.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop)
                  )
              )
          ),
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: fridayList.length,
                itemBuilder: (BuildContext context,int index){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("Workout: ",style: TextStyle(fontSize: 35),),

                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('${fridayList[index]['Friday']}',
                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),


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
                      MaterialPageRoute(builder: (context) => WorkoutScreen()),
                    );
                  }, child: Icon(Icons.whatshot)),
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
                MaterialPageRoute(builder: (context) => AddFridayWorkout()),
              );
            }, child: Icon(Icons.add)),
      ),
    );
  }
}
