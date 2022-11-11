
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ura_taxi/screens/auth/login.dart';

class AppClient {
  Future getCurrentUser(BuildContext context) async {
    User? _user = await FirebaseAuth.instance.currentUser;
    //final _user =Provider.of<User?>(context);
   // print("User: ${_user?.displayName}");
    return _user;}


  Future<void> signOut(BuildContext context) async {
    try {
     await FirebaseAuth.instance.signOut();
     Navigator.of(context).push(MaterialPageRoute(
         builder: (BuildContext context) =>  LoginScreen()));
    }catch(e){
       print("signout err:"+e.toString());
      }
    }
  }
