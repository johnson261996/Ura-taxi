import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
        backgroundColor: Color(0xff804ed1),
        title: Text('About Us'),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/ora_pic.png',
                width: 100,
                height: 100,
              ),
          ),
          Text("Ura Taxi",style: TextStyle(fontWeight: FontWeight.bold),),
          Text("version 1.0.0"),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 5,
              child:Column(
                children: [
                  ListTile(
                    title: Text(Strings.about_us_title),
                  ),
                  Divider(
                    thickness: 1,
                    height: 10,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.black,
                  ),
                  ListTile(
                    title: Text(Strings.about_us_sub_title),
                  ),
                ],
              )

            ),
          )
        ],
      ),
    );
  }
}


