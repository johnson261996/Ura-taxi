import 'dart:async';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:ura_taxi/widgets/home/choose_ride_widget.dart';
import 'package:ura_taxi/widgets/home/search_address_widget.dart';
import 'package:uuid/uuid.dart';
import '../../model/place.dart';
import '../navigationdrawer/home_menu_drawer.dart';

class HomeWidget extends StatefulWidget {

  const HomeWidget( {Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}


class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();
  final Completer<GoogleMapController> _completer = Completer();

  CameraPosition _initialLocation = CameraPosition(target: LatLng(20.0, 78.0));
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  bool done = false;
  late String error;
  final  sessionToken = Uuid().v4();
  //late PlaceApiProvider apiClient;


  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });


  }
  @override
  void dispose() {
    startAddressController.dispose();
    destinationAddressController.dispose();
    super.dispose();

  }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required double width,
    required Icon prefixIcon,
    required bool readonly,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        readOnly: readonly ,
        decoration:  InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void showBottomPanel() {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)),
          ),
          context: context, builder: (context){

        return ChooseRideWidget();
      });
    }
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      bottomSheet: Container(
        height: 300,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(),
      ),
      drawer: Drawer(
        child: HomeMenuDrawer(key: null,),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialLocation,
            onMapCreated:(GoogleMapController controller) {
              mapController = controller;
            },
            markers: Set<Marker>.from(markers),
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: OutlinedButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide( color: Colors.transparent),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:  EdgeInsets.only(top:deviceHeight(context) *0.550 ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        width: width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 10),
                              InkWell(
                                onTap: ()async{
                                  final Suggestion? result = await showSearch(
                                    context: context,
                                    delegate: AddressSearch(sessionToken),

                                  );
                                  // This will change the text displayed in the TextField
                                  if (result != null) {
                                    final placeDetails = await PlaceApiProvider(sessionToken)
                                        .getPlaceDetailFromId(result.placeId);
                                    setState(() {
                                      startAddressController.text = result.description;
                                      _startAddress =   startAddressController.text ;
                                    });
                                  }
                                },
                                child: AbsorbPointer(
                                  child: _textField(
                                     // label: 'Start',
                                      hint: 'pick up',
                                      readonly: false,
                                      prefixIcon: Icon(Icons.circle,color: Colors.green,size: 10,),
                                      controller: startAddressController,
                                      focusNode: startAddressFocusNode,
                                      width: width,
                                      locationCallback: (String value) {
                                        setState(() {
                                          _startAddress = value;
                                          _startAddress =   startAddressController.text ;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: ()async{
                                  final Suggestion? result = await showSearch(
                                    context: context,
                                    delegate: AddressSearch(sessionToken),
                                  );
                                  // This will change the text displayed in the TextField
                                  if (result != null) {
                                    final placeDetails = await PlaceApiProvider(sessionToken)
                                        .getPlaceDetailFromId(result.placeId);
                                    setState(() {
                                      destinationAddressController.text = result.description;
                                      _destinationAddress= destinationAddressController.text;
                                    });
                                  }
                                },
                                child: AbsorbPointer(
                                  child: _textField(
                                     // label: 'Destination',
                                      hint: 'where to go?',
                                      readonly: true,
                                      prefixIcon: Icon(Icons.circle,color: Colors.red,size: 10,),
                                      controller: destinationAddressController,
                                      focusNode: desrinationAddressFocusNode,
                                      width: width,
                                      locationCallback: (String value)  {
                                        setState(() {

                                          _destinationAddress = value;
                                          _destinationAddress= destinationAddressController.text;
                                        });
                                      },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Visibility(
                                visible: _placeDistance == null ? false : true,
                                child: Text(
                                  'DISTANCE: $_placeDistance km',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: (_startAddress != '' &&
                                    _destinationAddress != '')
                                    ? () async {
                                  startAddressFocusNode.unfocus();
                                  desrinationAddressFocusNode.unfocus();
                                  setState(() {
                                    if (markers.isNotEmpty) markers.clear();
                                    if (polylines.isNotEmpty)
                                      polylines.clear();
                                    if (polylineCoordinates.isNotEmpty)
                                      polylineCoordinates.clear();
                                    _placeDistance = null;
                                  });

                                  _calculateDistance().then((isCalculated) {
                                    if (isCalculated) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Distance Calculated Sucessfully'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Error Calculating Distance'),
                                        ),
                                      );
                                    }
                                  });
                                  showBottomPanel();
                                }: null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Go'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purpleAccent,
                                  minimumSize: Size(width*0.8, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            top:deviceHeight(context)*0.640,
            right: 20,
            child: Align(
              alignment: Alignment.topRight,
              // add your floating action button
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: getLocation,
                child: Icon(Icons.location_on_rounded,
                color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getLocation() async{
    loc.Location currentLocation = loc.Location();
    var location = await currentLocation.getLocation();
    await Geolocator.getCurrentPosition()
        .then((Position position) async {

      await mapController.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
        target: LatLng(position.latitude ,position.longitude),
        zoom: 12.0,
      )));
      print(position.latitude);
      print(position.longitude);

      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }


  // Method for retrieving the address
  _getAddress() async {
    try {
      _currentPosition =  await Geolocator.getCurrentPosition();
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        print("current addr" + _currentAddress);
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
   Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      var startPlacemark = await locationFromAddress(_startAddress);
      var destinationPlacemark = await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    //const apiKey = "AIzaSyDdTqq2YrVXn4f-vctC0lanJ5VrVA_8wzU";
    const apiKey = "AIzaSyA94M7pjj-T_-FwCrYbnbKhWt5sWDNPeS4";
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.purple,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }





}
