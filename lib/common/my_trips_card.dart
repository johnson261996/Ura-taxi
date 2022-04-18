
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTripsCard extends StatefulWidget {
  const MyTripsCard({Key? key}) : super(key: key);

  @override
  State<MyTripsCard> createState() => _MyTripsCardState();
}

class _MyTripsCardState extends State<MyTripsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.directions_car_sharp, size: 14),
                      ),
                      TextSpan(
                        text: "Car",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                Container(

                  child: Text("completed",style:TextStyle(color: Colors.white,)),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.calendar_today, size: 14),
                      ),
                      TextSpan(
                          text: "2/4/2022",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.timer, size: 14),
                      ),
                      TextSpan(
                          text: "6:00:00:AM",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.money, size: 14,color: Colors.green,),
                      ),
                      TextSpan(
                          text: "100",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
            Padding(padding: EdgeInsets.fromLTRB(40, 30, 50, 10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconTheme(
                      data: new IconThemeData(
                          color: Colors.green),
                      child: new Icon(Icons.circle),
                    ),
                    Flexible(child: Text("Kodi Post Office, Kodi Rd, Kundapura, Karnataka 576201"))
                  ],
                ),
                IconTheme(
                  data: new IconThemeData(
                      color: Colors.black,size: 10),
                  child: new Icon(Icons.circle),
                ),
                IconTheme(
                  data: new IconThemeData(
                      color: Colors.black,size: 10),
                  child: new Icon(Icons.circle),
                ),
                IconTheme(
                  data: new IconThemeData(
                      color: Colors.black,size: 10),
                  child: new Icon(Icons.circle),
                ),
                IconTheme(
                  data: new IconThemeData(
                      color: Colors.black,size: 10),
                  child: new Icon(Icons.circle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconTheme(
                      data: new IconThemeData(
                          color: Colors.purpleAccent),
                      child: new Icon(Icons.location_on),
                    ),
                    Flexible(child: Text("Kodi Post Office, Kodi Rd, Kundapura, Karnataka 576201"))
                  ],
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
