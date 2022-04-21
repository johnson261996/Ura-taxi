import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/widgets/trips/tabs/pastwidget.dart';
import 'package:ura_taxi/widgets/trips/tabs/upcomingwidget.dart';

class MyTripsWidget extends StatefulWidget {
  const MyTripsWidget({Key? key}) : super(key: key);

  @override
  State<MyTripsWidget> createState() => _MyTripsWidgetState();
}

class _MyTripsWidgetState extends State<MyTripsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xff804ed1),
        title: Text('My Trips'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: const Material(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: Color(0xff804ed1),
                  tabs: [
                    Tab(text: "Past",),
                    Tab(text: "Upcoming",),
                  ],
                  labelColor: Colors.deepPurpleAccent,
                  unselectedLabelColor: Colors.black,
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  PastWidget(),
                  UpcomingWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
