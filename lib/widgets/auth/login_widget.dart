import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ura_taxi/resources/images.dart';
import 'package:ura_taxi/screens/home/home.dart';
import '../../routes/routes.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _email, _passwaord;
  bool _showSpinner = false;
  late User _user;
  bool isLoggedIn = false;



  void onLoginStatusChanged(bool isLoggedIn) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    setState(() {
      _showSpinner = true;
    });
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      if (facebookLoginResult.status == LoginStatus.success) {
        // you are logged
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        final AccessToken accessToken = facebookLoginResult.accessToken!;
      } else {
        print(facebookLoginResult.status);
        print(facebookLoginResult.message);
      }
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential( facebookAuthCredential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

    }on FirebaseAuthException catch(e){
     var title = "";
     switch(e.code){
       case "invalid-credential":
       //Thrown if the email address is not valid.
         title = "unknown error ocuured";
         break;
       case "user-disabled":
       //Thrown if the user corresponding to the given email has been disabled.
         title = "the user you tried to log is disabled";
         break;
       case "user-not-found":
       //Thrown if there is no user corresponding to the given email.
         title = "the user you tried to log is not found";
         break;
       case "operation-not-allowed":
         title = "the operation is not allowed";
         break;
       case "account-exist-with-different-credential":
         title = "this account exist with different sign in";
         break;
     //Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
       default:
         throw "error";
     }
    }finally{
      _showSpinner = false;
    }

  }

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  void signin()  {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.pushReplacementNamed(context, Routes.home);
    }
    //  Navigator.pushReplacementNamed(context, Routes.home);
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
    return Column(
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
                       onTap: () {
                         signup(context);
                       }, // Image tapped
                       child: Image.asset(
                         Images.google_Img,
                         fit: BoxFit.cover, // Fixes border issues
                         width: 50.0,
                         height: 50.0,
                       ),
                     ),
                     const SizedBox(width: 20,),
                     GestureDetector(
                       onTap: () {
                         initiateFacebookLogin();
                       }, // Image tapped
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
    );
  }
}
