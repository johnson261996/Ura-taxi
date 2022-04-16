//@dart=2.9
import 'package:flutter/material.dart';
import 'package:ura_taxi/routes/routes.dart';
import 'package:ura_taxi/screens/splash/splash.dart';


void main() {
  runApp(const MyApp());
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

