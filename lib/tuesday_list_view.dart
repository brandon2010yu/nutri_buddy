import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_tuesday_workout.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'home_screen.dart';

class TuesdayListView extends StatefulWidget {
  const TuesdayListView({Key? key}) : super(key: key);

  @override
  _TuesdayListViewState createState() => _TuesdayListViewState();
}

class _TuesdayListViewState extends State<TuesdayListView> {
  var tuesdayList = [];

  _TuesdayListViewState() {
    refreshBreakfastList();
    FirebaseDatabase.instance.reference().child("tuesdayworkout").onChildChanged.listen((event) {
      print("data changed");
      refreshBreakfastList();
    });
  }

  void refreshBreakfastList(){
    FirebaseDatabase.instance.reference().child("tuesdayworkout").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      var breakfastTmpList = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        tuesdayList = breakfastTmpList;
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
                itemCount: tuesdayList.length,
                itemBuilder: (BuildContext context,int index){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("Workout: ",style: TextStyle(fontSize: 35),),

                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('${tuesdayList[index]['Tuesday']}',
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
                MaterialPageRoute(builder: (context) => AddTuesdayWorkout()),
              );
            }, child: Icon(Icons.add)),
      ),
    );
  }
}
