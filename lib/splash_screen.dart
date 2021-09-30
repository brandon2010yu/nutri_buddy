import 'package:flutter/material.dart';
import 'package:nutri_buddy/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigatetologin();

  }
  _navigatetologin()async{
    await Future.delayed(Duration(milliseconds: 4000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash.jpg"),
              fit: BoxFit.cover,
            )
          )
        ),

          Center(child: Container(
            margin: EdgeInsets.only(top:70),
              child: Text("NutriBuddy",style: TextStyle(
                  inherit: true,
                  fontSize:80,color: Colors.white,fontWeight:FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  offset: Offset(-4, -4),
                  color: Colors.black
                ),
                Shadow(
                    offset: Offset(-4, -4),
                    color: Colors.black
                ),
                Shadow(
                    offset: Offset(-4, -4),
                    color: Colors.black
                ),
                Shadow(
                    offset: Offset(-4, -4),
                    color: Colors.black
                ),
              ]),))),


    ]
      )



    );
  }
}
