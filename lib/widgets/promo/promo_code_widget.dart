
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/strings.dart';

class PromoCodeWidget extends StatefulWidget {
  const PromoCodeWidget({Key? key}) : super(key: key);

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xff804ed1),
        title: Text('Promo Code'),
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,),
                borderRadius: BorderRadius.all(Radius.circular(16),),),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(15) ,bottomLeft: Radius.circular(15)),
                    child: Container(
                      width: 40,
                      height: 50,
                      color: Colors.green,
                      child: Icon(
                        Icons.stay_primary_landscape_outlined,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: Strings.promo_code_hint
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              color: Colors.pink[100],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OFF52',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                        // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                        fontSize: 30.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '52%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                            fontSize: 40.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'use this \ncoupon \nto get 52 off', textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300, // -> Roboto-Light.ttf
                              // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape:  RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(20.0),
                                //side: BorderSide(color: Colors.white)
                            ),
                          ),
                          child: Text(
                              "Apply",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              color: Colors.green[100],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OFF52',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                        // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                        fontSize: 30.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '52%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                            fontSize: 40.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'use this \ncoupon \nto get 52 off', textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300, // -> Roboto-Light.ttf
                              // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape:  RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(20.0),
                              //side: BorderSide(color: Colors.white)
                            ),
                          ),
                          child: Text(
                            "Apply",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              color: Colors.blue[100],
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OFF52',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                        // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                        fontSize: 30.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '52%',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w800, // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                            fontSize: 40.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'use this \ncoupon \nto get 52 off', textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300, // -> Roboto-Light.ttf
                              // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shape:  RoundedRectangleBorder(
                              borderRadius:  BorderRadius.circular(20.0),
                              //side: BorderSide(color: Colors.white)
                            ),
                          ),
                          child: Text(
                            "Apply",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
