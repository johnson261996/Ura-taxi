import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ura_taxi/widgets/ride_picker_page.dart';
import '../model/place_item_res.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  RidePicker(this.onSelected);

  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
   PlaceItemRes fromAddress = PlaceItemRes("", "address", 4125, 1545454);
   PlaceItemRes toAddress = PlaceItemRes("", "address", 4125, 1545454);
   static const kGoogleApiKey = "AIzaSyDdTqq2YrVXn4f-vctC0lanJ5VrVA_8wzU";

   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


   Future<Null> displayPrediction(Prediction? p) async {
     if (p != null) {
       PlacesDetailsResponse detail =
       await _places.getDetailsByPlaceId(p.placeId!);

       var placeId = p.placeId;
       double lat = detail.result.geometry!.location.lat;
       double lng = detail.result.geometry!.location.lng;

       var address = await Geocoder.local.findAddressesFromQuery(p.description);

       print(lat);
       print(lng);
     }
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color(0x88999999), offset: Offset(0, 5), blurRadius: 5.0)
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: ()async {
             /*   Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RidePickerPage(fromAddress == null ? "" :fromAddress.name,
                            (place, isFrom) {

                          widget.onSelected(place, isFrom);
                          fromAddress = place;
                          setState(() {});
                        }, true)));*/
                Prediction? p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                  radius: 10000000,
                  types: [],
                  strictbounds: false,
                  mode: Mode.overlay,
                  language: "fr",
                  decoration: InputDecoration(
                    hintText: 'Search',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  components: [Component(Component.country, "fr")],);
                displayPrediction(p!);

              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                      width: 50.0,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: Colors.black)),
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 50.0),
                      child: Text(
                        "pickup location" ,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: fromAddress == null ? Colors.grey : Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RidePickerPage(toAddress == null ? '' : toAddress.name,
                                (place, isFrom) {
                              widget.onSelected(place, isFrom);
                              toAddress = place;
                              setState(() {});
                            }, false)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                      width: 50.0,
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: Colors.blue)),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.0, right: 50.0),
                      child: Text(
                         "where to go ?",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: toAddress == null ? Colors.grey: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}