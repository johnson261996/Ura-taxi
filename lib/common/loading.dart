import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget{
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: LoadingIndicator(indicatorType: Indicator.ballRotateChase, color: Colors.white,),
      ),
    );
  }

}