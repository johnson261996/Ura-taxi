

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:ura_taxi/screens/auth/login.dart';
import 'package:ura_taxi/screens/home/home.dart';
import 'package:ura_taxi/screens/intro/intro.dart';

import '../../utils/Appclient.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if ( FirebaseAuth.instance.currentUser != null) {
    // signed in
      return HomeScreen();
    } else {
     return LoginScreen();
    }
   /* return  AppClient().getCurrentUser(context) != null
        ? HomeScreen()
        : LoginScreen();*/

  }


}