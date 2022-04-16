import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/images.dart';

import '../../routes/routes.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String _email, _passwaord;

  void signin()  {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
    //  Navigator.pushReplacementNamed(context, Routes.home);
    }
      Navigator.pushReplacementNamed(context, Routes.home);
  }

 static bool isValidEmail(String email) {
   print("email bool:" + RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email).toString());
    return RegExp(
       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Center(
      child: Column(
      children: <Widget>[
           Container(
             margin: const EdgeInsets.only(top: 50),
             child: const Image(
               image: AssetImage(Images.Splash_Logo),
              ),
           ),

          // E-mail TextField
           Container(
             padding: EdgeInsets.all(16),
             child: Form(
               key: _formkey,
               child: Column(
                 children: [
                 const Text("Login for User" ,style: TextStyle(color: Color(0xff804ed1), fontSize: 25.0,),),
                   SizedBox(height: 30,),
                   // E-mail TextField
                   Container(
                     child: TextFormField(
                       keyboardType: TextInputType.emailAddress,
                       cursorColor: Colors.black,
                       style: TextStyle(color: Colors.black),
                       validator: (input) {
                         print("value:" + input.toString());
                          if(input!.isEmpty){
                           return "Email can't be empty";
                         }
                          else if (!isValidEmail(input)) {
                            return 'Enter a valid  email';
                          }
                       },
                       decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                               borderSide:
                               const BorderSide(color: Colors.transparent),
                               borderRadius:
                               BorderRadius.circular(30)),
                           contentPadding: EdgeInsets.all(15),
                           prefixIcon: Icon(
                             Icons.mail_outline,
                             color: Color(0xff804ed1),
                           ),
                           filled: true,
                           fillColor:  Color(0xfff1edfb),
                           //focusColor: Colors.red,
                           focusedBorder: OutlineInputBorder(
                               borderSide:
                               BorderSide(color: Colors.white),
                               borderRadius:
                               BorderRadius.circular(30)),
                           hintStyle: TextStyle(color: Colors.grey),
                           hintText: 'E-mail'),
                       onSaved: (input) => _email = input!,
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.all(10),
                   ),
                   // Password TextField
                   Container(
                     child: TextFormField(
                       keyboardType: TextInputType.text,
                       cursorColor: Colors.black12,
                       style: TextStyle(color: Colors.black),
                       obscureText: true,
                       validator: (input) {
                         if (input!.isEmpty) {
                           return 'Password cant be empty';
                         }
                       },
                       decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                               borderSide:
                               BorderSide(color: Colors.transparent),
                               borderRadius:
                               BorderRadius.circular(30)),
                           contentPadding: EdgeInsets.all(15),
                           prefixIcon: const Icon(
                             Icons.lock,
                             color: Color(0xff804ed1),
                           ),
                           filled: true,
                             fillColor: Color(0xfff1edfb),
                          // focusColor: Colors.blue,
                           focusedBorder: OutlineInputBorder(
                               borderSide:
                               BorderSide(color: Colors.white),
                               borderRadius:
                               BorderRadius.circular(30)),
                           hintStyle: TextStyle(color: Colors.grey),
                           hintText: 'Passwod'),
                       onSaved: (input) => _passwaord = input!,
                     ),
                   ),
                   const Padding(
                     padding: EdgeInsets.only(top: 20),
                   ),

                   //  Sign In button
                   ElevatedButton(
                       onPressed: (){
                          signin();
                       },
                       style:
                       ElevatedButton.styleFrom(
                         padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                         primary: Color(0xff804ed1),
                         shape: StadiumBorder(),
                         minimumSize: Size(mediaQuery.width * 0.9, mediaQuery.height * 0.015)
                       ),
                       child: Text(
                         'Log In',
                         style: TextStyle(
                             color: Colors.white, fontSize: 20)
                       )),
                   Padding(
                     padding: EdgeInsets.only(top: 20),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       GestureDetector(
                         onTap: () {}, // Image tapped
                         child: Image.asset(
                           Images.google_Img,
                           fit: BoxFit.cover, // Fixes border issues
                           width: 50.0,
                           height: 50.0,
                         ),
                       ),
                       const SizedBox(width: 20,),
                       GestureDetector(
                         onTap: () {}, // Image tapped
                         child: Image.asset(
                           Images.facebook_img,
                           fit: BoxFit.cover, // Fixes border issues
                           width: 50.0,
                           height: 50.0,
                         ),
                       )
                     ],
                   ),
                   const SizedBox(height: 20,),
                   // Text Button to Sign Up page
                   GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, Routes.forgotpassword);
                    },
                     child: const Text(
                       'Forgot password ?',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                           fontSize: 16.0, color: Colors.black),
                     ),
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children:  [
                       const Text(
                         'New User?',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             fontSize: 16.0, color: Colors.black),
                       ),
                       const SizedBox(width:10),
                       GestureDetector(
                         onTap: (){
                           Navigator.pushReplacementNamed(context, Routes.signup);
                         },
                         child: const Text(
                           'Create Account',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               fontSize: 16.0, color: Color(0xffa37edc)),
                         ),
                       ),
                     ],
                   )
                 ],

               ),
             ),
           ),



        ]
      ),
    );
  }
}
