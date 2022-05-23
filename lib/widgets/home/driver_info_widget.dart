
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class DriverInfoWidget extends StatefulWidget {
  const DriverInfoWidget({Key? key}) : super(key: key);

  @override
  State<DriverInfoWidget> createState() => _DriverInfoWidgetState();
}

class _DriverInfoWidgetState extends State<DriverInfoWidget> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;
  late double value;

  void cancelDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure want to cancel ride'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  });
                },
                child: const Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
          if(animation.value==1.0)
            bottomDraggbleSheet();

        });
      });
    controller.forward();
  }

void bottomDraggbleSheet(){
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0)),
      ),
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_){
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 3,
              indent: 150,
              endIndent: 150,
            ),

            Center(child: Text(Strings.your_ride_cnfm,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(height: 5,),

            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ka15ffaf69".toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      Text("White Maruti Suzuki Dzire ",style: TextStyle(fontSize: 15,color: Colors.grey),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("ramesh M",style: TextStyle(fontSize: 15,color: Colors.grey),),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Text("4.6",style: TextStyle(fontSize: 15,color: Colors.grey),)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width:  MediaQuery.of(context).size.width / 2,
                  height: 100,
                  child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          right: 100,
                          child: CircleAvatar(
                            radius: 20.0,
                            child: ClipRRect(
                              child: Image.asset('assets/images/driver.png'),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 80,
                            child: Image(image: AssetImage('assets/images/car.png',),width: 50,height: 50,)),
                        Positioned(
                          right: 50,
                          child: Container(
                              width: 100,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.shield,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("Vaccinated".toUpperCase(),style: TextStyle(fontSize: 10,color: Colors.white)),
                                ],
                              )
                          ),
                        )

                      ]
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call,color: Colors.black,size: 15,),
                    label: Text("Contact ",style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.close,color: Colors.black,size: 15,),
                    label: Text("Cancel ",style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: Icon(Icons.help,color: Colors.black,size: 15,),
                    label: Text("Support",style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.all(10.0),
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,color: Colors.green,size: 10,),
                        Container(color: Colors.grey, height: 30, width: 2,),
                        Icon(Icons.circle,color: Colors.red,size: 10,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text("Jayakirana Building, Circuit House...",style: TextStyle(fontSize: 15,),),
                            Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        const Divider(
                          thickness: 5, // thickness of the line
                          indent: 20, // empty space to the leading edge of divider.
                          endIndent: 20, // empty space to the trailing edge of the divider.
                          color: Colors.grey, // The color to use when painting the line.
                          height: 20, // The divider's height extent.
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            Text("Jayakirana Building, Circuit House...",style: TextStyle(fontSize: 15,),),
                            Text("Edit",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 270,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("Total Fare \u{20B9}375",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold) ,),
                          const Divider(
                            color: Colors.grey,
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          ListTile(
                              leading: const Icon(Icons.money,color: Colors.green,size: 30,),
                              title: const Text("Cash",style:TextStyle(fontWeight: FontWeight.bold) ),
                              subtitle: const Text('Pay when the ride ends',style:TextStyle(color: Colors.grey)),
                              trailing: const Text('Change',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue) ),
                              onTap: () => print("ListTile")
                          ),
                          ListTile(
                              leading: const Image(image: AssetImage('assets/images/paytm_icon.png',),width: 30,height: 30,),
                              title: Expanded(child: const Text(Strings.paytm_title,style:TextStyle(color: Colors.green) )),
                              subtitle: Expanded(child: const Text(Strings.paytm_sub_title,style:TextStyle(color: Colors.grey))),
                              trailing: const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 10,),
                              onTap: () => print("ListTile")
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  });
}


  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Divider(
            thickness: 3, // thickness of the line
            indent: 150, // empty space to the leading edge of divider.
            endIndent: 150, // empty space to the trailing edge of the divider.
            color: Colors.grey, // The color to use when painting the line.
            height: 20, // The divider's height extent.
          ),
          SizedBox(height: 5,),
          Text(
            Strings.contact_driver,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),
          LinearProgressIndicator(
            value:  animation.value,
            backgroundColor: Color(0xFFB4B4B4),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(height: 25,),
          Image(image: AssetImage('assets/images/driver.png'),width: 100,height: 100,),
          SizedBox(height: 25,),
          MaterialButton(
            child: Text('Cancel Ride'),
            height: 30,
            color: Colors.white,
            textColor: Colors.black,
            minWidth: 280,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), onPressed: () {
            cancelDialog(context);
          },
          )
        ]
    );
  }
}
