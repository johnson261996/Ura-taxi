import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/my_trips_card.dart';

class PastWidget extends StatefulWidget {
  const PastWidget({Key? key}) : super(key: key);

  @override
  State<PastWidget> createState() => _PastWidgetState();
}

class _PastWidgetState extends State<PastWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // the number of items in the list
        itemCount:2,

        // display each item of the product list
        itemBuilder: (context, index) {
          return MyTripsCard();
        });
  }
}
