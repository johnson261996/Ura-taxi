//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ura_taxi/routes/routes.dart';
import 'package:ura_taxi/screens/splash/splash.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(/*options:
  FirebaseOptions(appId: "1:911864620462:android:8d6e41f41fcf83f8e7143f",
  projectId: "ura-taxi-347103", messagingSenderId: '911864620462'),*/);
  return runApp(
      const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ura Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: './',
      routes : Routes.buildRoutes,
      home: const SplashScreen(),
    );
  }
}

