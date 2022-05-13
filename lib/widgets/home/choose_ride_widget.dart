
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/strings.dart';

class ChooseRideWidget extends StatefulWidget {
  const ChooseRideWidget({Key? key}) : super(key: key);

  @override
  State<ChooseRideWidget> createState() => _ChooseRideWidgetState();
}

class _ChooseRideWidgetState extends State<ChooseRideWidget> {

  void showBottomVehicleSheet(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0)),
        ),
        context: context,
        builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/images/car.png'),width: 40,height: 40,),
                    Expanded(child: Text("3 min",style: TextStyle(fontSize: 10)))
                  ],
                ),
                title: Text("Book any",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("Mini,Prime Sedan",style: TextStyle(fontSize: 10,color: Colors.grey)),
                onTap: () {},
                trailing: Text("\u{20B9}351-\u{20B9}400"),
                dense:true,
                visualDensity: VisualDensity(vertical: 3),
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Column(
                  children: [
                    Image(image: AssetImage('assets/images/rickshaw.png'),width: 30,height: 30,),
                    Expanded(child: Text("3 min",style: TextStyle(fontSize: 10)))
                  ],
                ),
                title: Text("Auto",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("Get autos at your door step",style: TextStyle(fontSize: 10,color: Colors.grey)),
                onTap: () {},
                trailing: Text("\u{20B9}151"),
                dense:true,
                visualDensity: VisualDensity(vertical: 3),
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Column(
                  children: [
                    Image(image: AssetImage('assets/images/suv.png'),width: 30,height: 30,),
                    Expanded(child: Text("3 min",style: TextStyle(fontSize: 10)))
                  ],
                ),
                title: Text("suv",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("comfy economical cars",style: TextStyle(fontSize: 10,color: Colors.grey)),
                onTap: () {},
                trailing: Text("\u{20B9}151"),
                dense:true,
                visualDensity: VisualDensity(vertical: 3),
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Image(image: AssetImage('assets/images/coupon_icon.png'),width: 30,height: 30,),
                title: Text("Apply Coupon Code",style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {},
                trailing:   Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                dense:true,
                visualDensity: VisualDensity(vertical: 3),
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Image(image: AssetImage('assets/images/rupee_icon.png'),width: 30,height: 30,),
                title: Text("cash",style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {},
                trailing:   Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                dense:true,
                visualDensity: VisualDensity(vertical: 3),
              ),
              SizedBox(height: 5,),
              MaterialButton(
                child: Text('Book Any'),
                height: 50,
                color: Colors.purple,
                textColor: Colors.white,
                minWidth: 280,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), onPressed: () {  },
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              Text(Strings.someone_take_ride_title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(Strings.someone_take_ride_subtitle,style: TextStyle(color: Colors.grey,fontSize: 15),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Radio(
                      value: "myself",
                      groupValue: "myself",
                      onChanged: (value){
                        setState(() {
                          // gender = value.toString();
                        });
                      }),
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5,),
                  Text("Myself",style: TextStyle(fontSize: 15),)
                ],
              ),
              const Divider(
                thickness: 1, // thickness of the line
                indent: 45, // empty space to the leading edge of divider.
                endIndent: 5, // empty space to the trailing edge of the divider.
                color: Colors.grey, // The color to use when painting the line.
                height: 20, // The divider's height extent.
              ),
              Row(
                children: [
                  SizedBox(width: 45,),
                  Icon(
                    Icons.contact_page,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5,),
                  Text(Strings.someone_take_ride_contact,style: TextStyle(fontSize: 15,color: Colors.blue),),
                  SizedBox(width: 25,),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 15,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    height: 50.0,
                    minWidth: 150.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.grey[200],
                    textColor: Colors.black,
                    child:  Text("skip"),
                    onPressed: () => {},
                    splashColor: Colors.redAccent,
                  ),

                  MaterialButton(
                    height: 50.0,
                    minWidth: 150.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    textColor: Colors.white,
                    child:  Text("Continue"),
                    onPressed: () {
                      Navigator.pop(context);
                      showBottomVehicleSheet();
                    }
                  )
                ],
              )
            ],
          ),
        ),
      ]

    );
  }
}
