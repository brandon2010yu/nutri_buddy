import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_lunch_screen.dart';

import 'home_screen.dart';

class LunchListView extends StatefulWidget {
  const LunchListView({Key? key}) : super(key: key);

  @override
  _LunchListViewState createState() => _LunchListViewState();
}

class _LunchListViewState extends State<LunchListView> {

  var foodList = [];
  var foodList2 = [];

  _LunchListViewState() {
    refreshBreakfastList();
    FirebaseDatabase.instance.reference().child(uid.toString() + "/lunch").onChildChanged.listen((event) {
      print("data changed");
      refreshBreakfastList();
    });
  }

  void refreshBreakfastList(){
    FirebaseDatabase.instance.reference().child(uid.toString() + "/lunch").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      var breakfastTmpList = [];
      var breakfastTmpList2 = [];
      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        breakfastTmpList2.add(k);
        foodList = breakfastTmpList;
        foodList2 = breakfastTmpList2;
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
                      image: AssetImage("assets/home.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(.6), BlendMode.dstATop)
                  )
              )
          ),
          Container(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: foodList.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    onLongPress: () {
                      FirebaseDatabase.instance.reference().child(uid.toString() + "/lunch/" + foodList2[index]).remove();
                      foodList.removeAt(index);
                      foodList2.removeAt(index);

                      setState(() {

                      });
                    },
                    title: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Row(
                            children: [
                              Flexible(

                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text("Name: ",style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)),
                              ),
                              Flexible(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(),
                                    child: Text('${foodList[index]['Name']}',
                                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Flexible(child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Calories: ",style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),))),
                              Flexible(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text('${foodList[index]['Calorie']}',style: TextStyle(
                                        fontSize: 25,fontWeight: FontWeight.bold
                                    ),)),
                              ),
                            ],
                          )
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
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }, child: Icon(Icons.home)),
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
                        FirebaseDatabase.instance.reference().child(uid.toString() + "/lunch/").remove();
                        foodList2 = [];
                        foodList = [];
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
                MaterialPageRoute(builder: (context) => AddLunchScreen()),
              );
            }, child: Icon(Icons.add)),
      ),
    );
  }
}
