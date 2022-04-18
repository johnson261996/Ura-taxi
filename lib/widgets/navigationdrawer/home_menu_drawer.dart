import 'package:flutter/material.dart';
import 'package:ura_taxi/resources/images.dart';
import 'package:ura_taxi/routes/routes.dart';
import 'package:ura_taxi/screens/profile/profile.dart';
import 'package:ura_taxi/screens/trips/mytrips.dart';
import 'package:ura_taxi/utils/navigations.dart';
import 'package:ura_taxi/widgets/profile/profile_widget.dart';

class HomeMenuDrawer extends StatefulWidget {
  HomeMenuDrawer({required Key? key}) : super(key: key);

  _HomeMenuDrawerState createState() => _HomeMenuDrawerState();
}

class _HomeMenuDrawerState extends State<HomeMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
         UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Color(0xff804ed1)),
           accountName:Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               GestureDetector(
                 onTap: (){

                 },
                 child: Container(
                   child: ClipOval(
                     child: Image.asset(
                       Images.Splash_Logo,
                       width: 60,
                       height: 60,
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
               ),
             ],
           ),
          accountEmail: Center(child: Text("jason dsilva")),

          currentAccountPicture: null,

        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          linkMenuDrawer(context, "Profile",Icons.person,),
          linkMenuDrawer(context,'Notifications', Icons.notifications,),
          linkMenuDrawer(context,'My Rides',Icons.directions_car ,),
          linkMenuDrawer(context,'Payment',Icons.payment ,),
          linkMenuDrawer(context,'Promo code',Icons.qr_code, ),
          linkMenuDrawer(context,'Invite',Icons.insert_invitation ,),
          linkMenuDrawer(context,'About us',Icons.info_outline ,),
          linkMenuDrawer(context,'Support',Icons.chat ,),
          linkMenuDrawer(context,'Privacy and Policy',Icons.shield ,)

        ]),
      ],
    );
  }
}


 Widget linkMenuDrawer(BuildContext context,String title,IconData icon){
  return InkWell(
    onTap: (){
      Future.delayed(Duration.zero, () {

        openDrawerItems(context,title);
      });
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      width: double.infinity,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Icon(icon,size: 20.0,),
          SizedBox(width: 15,),
          Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ]     ,
      ),
    ),
  );
}

void openDrawerItems(BuildContext context,String DrawerItemName) {

  if("profile".toLowerCase()==DrawerItemName.toLowerCase()){
    Future.delayed(Duration.zero, () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ProfileScreen()));
    });

  }else if("Notifications"==DrawerItemName){

  }else if("My Rides".toLowerCase()==DrawerItemName.toLowerCase()){
    Future.delayed(Duration.zero, () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyTripsScreen()));
    });
  }else if("Payment"==DrawerItemName){

  }
}



