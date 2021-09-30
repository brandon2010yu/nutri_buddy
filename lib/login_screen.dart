import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutri_buddy/main.dart';
import 'package:nutri_buddy/signup_screen.dart';
import 'package:nutri_buddy/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 40,
            child: Image(
              image: (AssetImage('assets/login.jpg')),
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20,bottom:20,),
                  child: Text('NutriBuddy Login',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left:30, right:35, bottom:10, top:10,),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:35, right:35, bottom:10, top:10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(bottom: 10,top:5),
                    child: ElevatedButton(
                        style: ButtonStyle(

                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                )

                            )

                        ),

                        onPressed: (){

                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text, password: passwordController.text)
                              .then((value)
                          {
                            print("Login Successfully");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          }).catchError((error){
                            print("Failed to Log in");
                            print(error.toString());
                          });




                        },
                        child: Text('Login')),

                  ),
                ),
                Expanded(

                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 3,bottom:10),
                    child: ElevatedButton(
                        style: ButtonStyle(

                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                )

                            )

                        ),

                        onPressed: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );

                        },
                        child: Text('Sign Up')),

                  ),
                ),

              ],
            ),
          ),
          // Expanded(
          //   flex: 10,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //           margin: EdgeInsets.only(right:20),
          //           child: Text('App Logo')),
          //       IconButton(
          //         icon: Icon(Icons.book), onPressed: () {  },
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.computer), onPressed: () {  },
          //       ),
          //
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
