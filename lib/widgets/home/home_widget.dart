import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ura_taxi/routes/routes.dart';
import 'package:ura_taxi/utils/navigations.dart';
import '../../model/place_item_res.dart';
import '../../utils/map_util.dart';
import '../navigationdrawer/home_menu_drawer.dart';
import '../ride_picker.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final Completer<GoogleMapController> _completer = Completer();
  MapUtil mapUtil = MapUtil();
  Location _locationService = Location();
  late LatLng currentLocation;
  LatLng _center = LatLng(-8.913025, 13.202462);
  bool _permission = false;
  List<Marker> _markers = <Marker>[];
  List<Polyline> routes = <Polyline>[];
  bool done = false;
  late String error;


  @override
  Widget build(BuildContext context) {
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
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _completer.complete(controller);
            },
            markers: Set<Marker>.of(_markers),
            polylines: Set<Polyline>.of(routes),
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
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: RidePicker(onPlaceSelected),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            bottom:100,
            right: 5,
            child: Align(
              alignment: Alignment.bottomRight,
              // add your floating action button
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: _currentLocation,
                child: Icon(Icons.location_on_rounded,
                color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _completer.future;
    LocationData currentLocation;
    var location =  Location();
      currentLocation = await location.getLocation();

     // currentLocation = null;


    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    addPolyline();
  }

  void _addMarker(String mkId, PlaceItemRes place) async {
    // remove old
    _markers.remove(mkId);
    //_mapController.clearMarkers();

    Marker marker = Marker(
      markerId: MarkerId(mkId),
      draggable: true,
      position: LatLng(place.lat, place.lng),
      infoWindow: InfoWindow(title: mkId),
    );

    setState(() {
      if (mkId == "from_address") {
        _markers[0] = (marker);
        List mmmm = _markers;
        print(mmmm);
      } else if (mkId == "to_address") {
        _markers.add(marker);
        List mmmm = _markers;
        print(mmmm);
      }
    });
  }

  getCurrentLocation() async {
    currentLocation = await mapUtil.getCurrentLocation();
    _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    Marker marker = Marker(
      markerId: MarkerId('location'),
      position: _center,
      infoWindow: InfoWindow(title: 'My Location'),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  addPolyline() async {
    //routes.clear();
    if (_markers.length > 1) {
      mapUtil
          .getRoutePath(
          LatLng(_markers[0].position.latitude,
              _markers[0].position.longitude),
          LatLng(_markers[1].position.latitude,
              _markers[1].position.longitude))
          .then((locations) {
        List<LatLng> path =  <LatLng>[];

        locations.forEach((location) {
          path.add(new LatLng(location.latitude, location.longitude));
        });

        final Polyline polyline = Polyline(
          polylineId: PolylineId(_markers[1].position.latitude.toString() +
              _markers[1].position.longitude.toString()),
          consumeTapEvents: true,
          color: Colors.black,
          width: 2,
          points: path,
        );

        setState(() {
          routes.add(polyline);
        });
      });
    }
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = (await _locationService.requestPermission()) as bool;
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          Marker marker = Marker(
            markerId: MarkerId('from_address'),
            position: LatLng(location.latitude!, location.longitude!),
            infoWindow: InfoWindow(title: 'Minha localização'),
          );
          if (mounted) {
            setState(() {
              currentLocation = LatLng(location.latitude!, location.longitude!);
              _center =
                  LatLng(currentLocation.latitude, currentLocation.longitude);
              _markers.add(marker);
              done = true;
            });
          }
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message!;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message!;
      }
      //location = null;
    }
  }

}
