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
  var tuesdayList2 = [];

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
      var breakfastTmpList2 = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        breakfastTmpList2.add(k);

        tuesdayList = breakfastTmpList;
        tuesdayList2 = breakfastTmpList2;
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
                  return ListTile(
                    onLongPress: () {
                      FirebaseDatabase.instance.reference().child("tuesdayworkout/" + tuesdayList2[index]).remove();
                      tuesdayList.removeAt(index);
                      tuesdayList2.removeAt(index);

                      setState(() {

                      });
                    },
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Flexible(child: Text("Workout: ",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),

                          Flexible(
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('${tuesdayList[index]['Tuesday']}',
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                          ),


                        ],
                      ),
                    ),
                  );

                }),
          ),
          Row(
            children: [
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
              ),
              Container(
                margin: EdgeInsets.only(bottom: 52, left: 100),
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 56,
                  width: 56,
                  child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: CircleBorder(),

                      ),
                      onPressed: (){
                        FirebaseDatabase.instance.reference().child("tuesdayworkout/").remove();
                        tuesdayList2 = [];
                        tuesdayList = [];
                        setState(() {

                        });
                      }, child: Icon(Icons.clear)),
                ),
              ),
            ],
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
