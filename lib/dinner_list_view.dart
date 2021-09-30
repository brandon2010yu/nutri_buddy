import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/add_dinner_screen.dart';

import 'home_screen.dart';

class DinnerListView extends StatefulWidget {
  const DinnerListView({Key? key}) : super(key: key);

  @override
  _DinnerListViewState createState() => _DinnerListViewState();
}

class _DinnerListViewState extends State<DinnerListView> {


  var foodList = [];
  var foodList2 = [];

  _DinnerListViewState() {
    refreshBreakfastList();
    FirebaseDatabase.instance.reference().child("dinner").onChildChanged.listen((event) {
      print("data changed");
      refreshBreakfastList();
    });
  }

  void refreshBreakfastList(){
    FirebaseDatabase.instance.reference().child("dinner").once().then((datasnapshot)
    {
      print("Successfully loaded data");
      var breakfastTmpList = [];
      var breakfastTmpList2 = [];

      datasnapshot.value.forEach((k,v)
      {
        breakfastTmpList.add(v);
        breakfastTmpList2.add(k);
        foodList2 = breakfastTmpList2;
        foodList = breakfastTmpList;
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
                      FirebaseDatabase.instance.reference().child("dinner/" + foodList2[index]).remove();
                      foodList.removeAt(index);
                      foodList2.removeAt(index);

                      setState(() {

                      });
                    },
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(

                              child: Text("Name: ",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),)),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text('${foodList[index]['Name']}',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),

                          Text("Calories: ",style: TextStyle(fontSize: 20),),
                          Container(
                              child: Text('${foodList[index]['Calorie']}',style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold
                              ),))
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
                        FirebaseDatabase.instance.reference().child("dinner/").remove();
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
                MaterialPageRoute(builder: (context) => AddDinnerScreen()),
              );
            }, child: Icon(Icons.add)),
      ),
    );
  }
}
