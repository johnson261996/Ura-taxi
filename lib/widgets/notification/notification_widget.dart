
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
        backgroundColor: Color(0xff804ed1),
    title: Text('Notification'),
    ),
    body: ListView.builder(
    itemBuilder:((context, index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.only(top: 10,left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 15,
                      child: Icon(Icons.notifications,color: Colors.white,size: 15),
                    ),
                    SizedBox(width: 10,),
                    Text(Strings.notification_1,style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    child: Text(Strings.notification_2,style: TextStyle(fontSize: 12),)),
                Text("2 hours",style: TextStyle(fontSize: 10,color: Colors.grey[500]),)
              ],
            ),
          ),
        ),
      );
    } ),
    itemCount: 2,
    ));
  }
}
