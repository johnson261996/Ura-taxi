import 'package:flutter/material.dart';
import 'package:ura_taxi/containers/splash_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashContainer(),
    );
  }

}

