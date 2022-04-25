import 'package:flutter/cupertino.dart';

import '../../../common/my_trips_card.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({Key? key}) : super(key: key);

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // the number of items in the list
        itemCount:1,

        // display each item of the product list
        itemBuilder: (context, index) {
          return MyTripsCard();
        });
  }
}
