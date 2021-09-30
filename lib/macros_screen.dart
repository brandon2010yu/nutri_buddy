import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/workout_screen.dart';

import 'goals_screen.dart';
import 'home_screen.dart';

class MacrosScreen extends StatefulWidget {
  const MacrosScreen({Key? key}) : super(key: key);


  @override
  _MacrosScreenState createState() => _MacrosScreenState();
}

class _MacrosScreenState extends State<MacrosScreen> {

  var goal;
  var breakfastP = 0;
  var lunchP = 0;
  var dinnerP = 0;
  var breakfastC = 0;
  var lunchC = 0;
  var dinnerC = 0;
  var breakfastF = 0;
  var lunchF = 0;
  var dinnerF = 0;

  _MacrosScreenState(){
    FirebaseDatabase.instance.reference().child("goals").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      print(datasnapshot.value);
      var breakfastTmpList = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        goal = breakfastTmpList;
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
        breakfastP += int.tryParse(v['Protein'])!;
        breakfastC += int.tryParse(v['Carbohydrate'])!;
        breakfastF += int.tryParse(v['fat'])!;
        setState(() {

        });
      });
      print(breakfastP);
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });
    FirebaseDatabase.instance.reference().child("lunch").once().then((datasnapshot)
    {

      print("Successfully loaded data");
      datasnapshot.value.forEach((k,v)
      {
        lunchP += int.tryParse(v['Protein'])!;
        lunchC += int.tryParse(v['Carbohydrate'])!;
        lunchF += int.tryParse(v['fat'])!;

        setState(() {

        });
      });
    }).catchError((error){
      print("failed to load data");
      print(error.toString());
    });
    FirebaseDatabase.instance.reference().child("dinner").once().then((datasnapshot)
    {
      print("Successfully loaded data");

      datasnapshot.value.forEach((k,v)
      {
        dinnerP += int.tryParse(v['Protein'])!;
        dinnerC += int.tryParse(v['Carbohydrate'])!;
        dinnerF += int.tryParse(v['fat'])!;
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
                      image: AssetImage("assets/macros.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.5), BlendMode.dstATop)
                  )
              )
          ),
          Column(
            children: [
              Expanded(flex: 20,
                child: Container(
                  margin: EdgeInsets.only(top:20),
                  child: Text("Macros",
              style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
              ),),
                ),),

              Expanded(
                flex: 70,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("PROTEIN",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${(goal == null ? "" : goal[0]['Protein'])}',style: TextStyle(fontSize: 30),),
                              Text(" - ",style: TextStyle(fontSize: 30),),
                              Text("${breakfastP + lunchP + dinnerP}",style: TextStyle(fontSize: 30),),
                              Text(" = ",style: TextStyle(fontSize: 30),),
                              Text("${int.tryParse(goal == null ? "0" : goal[0]['Protein'])! - (breakfastP + lunchP + dinnerP)}",style: TextStyle(fontSize: 30),)

                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("CARBOHYDRATES",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${(goal == null ? "" : goal[0]['Carbohydrate'])}',style: TextStyle(fontSize: 30),),
                              Text(" - ",style: TextStyle(fontSize: 30),),
                              Text("${breakfastC + lunchC + dinnerC}",style: TextStyle(fontSize: 30),),
                              Text(" = ",style: TextStyle(fontSize: 30),),
                              Text("${int.tryParse(goal == null ? "0" : goal[0]['Carbohydrate'])! - (breakfastC + lunchC + dinnerC)}",style: TextStyle(fontSize: 30),)

                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("FATS",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${(goal == null ? "" : goal[0]['fat'])}',style: TextStyle(fontSize: 30),),
                              Text(" - ",style: TextStyle(fontSize: 30),),
                              Text("${breakfastF + lunchF + dinnerF}",style: TextStyle(fontSize: 30),),
                              Text(" = ",style: TextStyle(fontSize: 30),),
                              Text("${int.tryParse(goal == null ? "0" : goal[0]['fat'])! - (breakfastF + lunchF + dinnerF)}",style: TextStyle(fontSize: 30),)

                            ],
                          ),
                        ],
                      ),
                    )

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
