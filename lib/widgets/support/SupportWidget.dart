
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class SupportWidget extends StatefulWidget {
  const SupportWidget({Key? key}) : super(key: key);

  @override
  State<SupportWidget> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff804ed1),
        title: Text('Support'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
             Text(Strings.support_title ,style: TextStyle(color: Color(0xff804ed1), fontSize: 25.0,),),
             SizedBox(height: 30,),
            TextField(
              controller: _text,
              decoration: InputDecoration(
                hintText:"Tell your issue" ,
                fillColor: Colors.blue[300],
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _text.text.isEmpty ? _validate = true : _validate =false;
                  });

                },
                style: ElevatedButton.styleFrom(
                  shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Submit')
            ),
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.centerLeft,
                child: Text("Contatc Us",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
            ),
            SizedBox(height: 20,),
            Container(
              height: 80,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.call,
                        color: Color(0xff804ed1),
                        size: 20.0,
                        textDirection: TextDirection.ltr,
                        semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                      SizedBox(width: 10,),
                      Text("918864652525",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: Color(0xff804ed1),
                        size: 20.0,
                        textDirection: TextDirection.ltr,
                        semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                      SizedBox(width: 10,),
                      Text("contact@urataxi.com",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.house,
                        color: Color(0xff804ed1),
                        size: 20.0,
                        textDirection: TextDirection.ltr,
                        semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                      ),
                      SizedBox(width: 10,),
                      Text("ABC Street ,bihar india",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
