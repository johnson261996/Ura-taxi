import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/images.dart';

class ProfileWidget extends StatefulWidget  {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool male_value = false;
  bool female_value =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                   Container(
                     width: double.infinity,
                    height: 200.0,
                    color: Color(0xff804ed1),
                    child:  Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget>[
                                 InkWell(
                                   onTap: () =>  Navigator.of(context).pop(),
                                   child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 20.0,
                                ),
                                 ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child:  Text('My Profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.white)),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:  Stack(fit: StackFit.loose, children: <Widget>[
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                 Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration:  const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image:  DecorationImage(
                                        image:  ExactAssetImage(
                                            Images.Splash_Logo),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            const Positioned(
                              bottom: 0, right: 125,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  child:  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  radius: 13,
                                ),
                              ),
                            ),
                          ]
                        )
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                       Text(
                                        'First Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Flexible(
                                    child:  TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter First Name",
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(bottom: 20,top: 20),
                                      ),
                                      enabled: _status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Last Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child:  TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Last Name",
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                                      ),
                                      enabled: _status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                       Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                   Flexible(
                                    child:  TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      enabled: _status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25.0),
                      child:Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Gender",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: male_value,
                                onChanged: (value) {
                                  setState(() {
                                    male_value = value!;
                                    female_value = false;
                                  });
                                },
                              ),
                              const Text(
                                "Male",
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(width: 50,),
                              Checkbox(
                                value: female_value,
                                onChanged: (value) {
                                  setState(() {
                                    female_value = value!;
                                    male_value = false;
                                  });
                                },
                              ),
                              const Text(
                                "Female",
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child:  Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                             Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                 Text(
                                  'Phone no',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child:  Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                             Flexible(
                              child:  TextField(
                                decoration: const InputDecoration(
                                    hintText: "Enter Mobile Number"),
                                enabled: _status,
                              ),
                            ),
                          ],
                        )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child:  Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child:  TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter address",
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(bottom: 20,top: 20),
                                      ),
                                      enabled: _status,
                                      autofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          _status ? _getActionButtons() :  Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child:  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child:  OutlinedButton(
                    child:  Text("Submit",style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff804ed1),
                        shape: (RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(20.0),)
                        ),
                      ),
                  )),
            ),
          ),

        ],
      ),
    );
  }



}


