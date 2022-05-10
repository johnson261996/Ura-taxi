import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key}) : super(key: key);

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xff804ed1),
    title: Text('Privacy Policy'),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Effective date:2021-12-31"),
            Text("Introduction".toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(Strings.privacy_policy),
            Text("DEFINITIONS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(Strings.privacy_policy2),
            Text("USE OF INFORMATION COLLECTED",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(Strings.privacy_policy3),
            Text("Information you provided to us".toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(Strings.privacy_policy4),
          ],
        )


      ),
    )
    );
  }
}
