import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/widgets/home/driver_info_widget.dart';

class SelectVehicleBottomSheet extends StatefulWidget {
  const SelectVehicleBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectVehicleBottomSheet> createState() => _SelectVehicleBottomSheetState();
}

class _SelectVehicleBottomSheetState extends State<SelectVehicleBottomSheet> {
  String vehicle = "Any";
  bool isClciked = false;

  void bb(String v) {
    print('Clicked Clicked');
    setState(() {
      vehicle = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Image(
                              image: AssetImage('assets/images/car.png'),
                              width: 40,
                              height: 40,
                            ),
                            Expanded(
                                child:
                                Text("3 min", style: TextStyle(fontSize: 10)))
                          ],
                        ),
                        title: Text(
                          "Book any",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Mini,Prime Sedan",
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                        onTap: () {
                          vehicle = "any";
                          bb(vehicle);
                        },
                        trailing: Text("\u{20B9}351-\u{20B9}400"),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/images/rickshaw.png'),
                              width: 30,
                              height: 30,
                            ),
                            Expanded(
                                child:
                                Text("3 min", style: TextStyle(fontSize: 10)))
                          ],
                        ),
                        title: Text(
                          "Auto",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Get autos at your door step",
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                        onTap: () {
                          vehicle = "Auto";
                          bb(vehicle);
                          print("ListTile" + vehicle);
                        },
                        trailing: Text("\u{20B9}151"),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/images/suv.png'),
                              width: 30,
                              height: 30,
                            ),
                            Expanded(
                                child:
                                Text("3 min", style: TextStyle(fontSize: 10)))
                          ],
                        ),
                        title: Text(
                          "suv",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("comfy economical cars",
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                        onTap: () {
                          vehicle = "suv";
                          bb(vehicle);
                          print("ListTile" + vehicle);
                        },
                        trailing: Text("\u{20B9}151"),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/coupon_icon.png'),
                          width: 30,
                          height: 30,
                        ),
                        title: Text(
                          "Apply Coupon Code",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/rupee_icon.png'),
                          width: 30,
                          height: 30,
                        ),
                        title: Text(
                          "cash",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                        dense: true,
                        visualDensity: VisualDensity(vertical: 3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      MaterialButton(
                        child: Text('Book ${vehicle}'),
                        height: 50,
                        color: Colors.purple,
                        textColor: Colors.white,
                        minWidth: 280,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                              ),
                              context: context,
                              builder: (context) {
                                return DriverInfoWidget();
                              });
                        },
                      )
                    ],
                  ),
                ),
              )
            ])));
  }
}
