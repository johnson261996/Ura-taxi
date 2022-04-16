import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/images.dart';
import 'package:ura_taxi/screens/intro/intro.dart';
import 'package:ura_taxi/widgets/intro/intro_widget.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  startTime() async {
    var _duration =  const Duration(seconds: 2);
    return  Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const IntroScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        fit: StackFit.expand,
        children: <Widget>[ Image.asset(Images.Splash_Logo)],
      ),
    );
  }
}
