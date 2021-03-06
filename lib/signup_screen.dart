import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutri_buddy/login_screen.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 35,
            child: Image(
              image: (AssetImage('assets/signup.jpg')),
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20,bottom:20,),
                  child: Text('NutriBuddy Sign Up',
                      style: TextStyle(
                        fontSize: 40,
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


                Container(
                  width: 200,
                  height: 60,
                  margin: EdgeInsets.only(top: 15),
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
                        //1. get the email and password typed
                        print(emailController.text);
                        print(passwordController.text);
                        // 2. send it to firebase Auth
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text)
                            .then((value){

                          print("Successfully signed up!");
                          Navigator.pop(context);
                        }).catchError((error){
                          print("Failed to sign up");
                          print(error.toString());
                        });


                      },
                      child: Text('Sign Up')),

                ),
                Container(
                  width: 200,
                  height: 60,
                  margin: EdgeInsets.only(top: 15),
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
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );


                      },
                      child: Text('Back')),

                ),


              ],
            ),
          ),

        ],
      ),
    );
  }
}
