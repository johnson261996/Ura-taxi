import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart' as PolyLineLib;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_directions_api/google_directions_api.dart' as google_dir;
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ura_taxi/simulator/web_socket_listener.dart';
import 'package:ura_taxi/utils/constants.dart';

import 'json_message.dart';

class Simulator{


 late LatLng currentLocation;

  /* LatLng pickUpLocation;
    LatLng dropUpLocation;*/

  var pickUpPath = <LatLng>[];


  getFakeNearByCabs(LatLng userLoc,WebSocketListener webSocketListener){

    var size = Random().nextInt(6);

    List<LatLng?>  nearByCabs=  <LatLng>[];

    JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
    jsonMessage.tag=Constants.nearByCabs;

    for (int  i=0; i<=size; i++) {

      var randomOperatorForLat = Random().nextInt(1);
      var randomOperatorForLng = Random(1).nextInt(1);

      var randomDeltaForLat = ((10+Random().nextInt(40)) /10000.00).toDouble();
      var randomDeltaForLng = ((10+Random().nextInt(40)) /10000.00).toDouble();

      if (randomOperatorForLat == 1) {
        randomDeltaForLat *= -1;
      }
      if (randomOperatorForLng == 1) {
        randomDeltaForLng *= -1;
      }
      var randomLatitude =  userLoc.latitude + randomDeltaForLat; //max((userLoc.latitude + randomDeltaForLat),90.00);
      var randomLongitude = userLoc.longitude + randomDeltaForLng;//max((userLoc.longitude + randomDeltaForLng),180.00);

      nearByCabs.add(LatLng(randomLatitude,randomLongitude));
    }

    jsonMessage.data=nearByCabs;

    var jsonObjectToPush = jsonEncode(jsonMessage);

    webSocketListener.onMessage(jsonObjectToPush);

  }



  requestCab( LatLng pickUpLocation, LatLng dropLocation, WebSocketListener webSocketListener) {

    var randomOperatorForLat = Random().nextInt(1);
    var randomOperatorForLng = Random(1).nextInt(1);

    var randomDeltaForLat = ((10+Random().nextInt(40)) /10000.00).toDouble();
    var randomDeltaForLng = ((10+Random().nextInt(40)) /10000.00).toDouble();

    if (randomOperatorForLat == 1) {
      randomDeltaForLat *= -1;
    }
    if (randomOperatorForLng == 1) {
      randomDeltaForLng *= -1;
    }

    var latFakeNearby =  pickUpLocation.latitude + randomDeltaForLat;
    var lngFakeNearby = pickUpLocation.longitude + randomDeltaForLng;

    var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);

    DirectionsService.init(Constants.kGoogleApiKey);

    final directinosService = DirectionsService();

    final request = DirectionsRequest(
      origin: "${pickUpLocation.latitude} ${pickUpLocation.longitude}",
      //destination: "${dropLocation.latitude} ${dropLocation.longitude}",
      destination: "${bookedCabCurrentLocation.latitude} ${bookedCabCurrentLocation.longitude}",
      travelMode:google_dir.TravelMode.driving,
    );

    pickUpPath.clear();

    directinosService.route(request,
            (DirectionsResult response, DirectionsStatus? status) {
          if (status == DirectionsStatus.ok) {

            if(response.routes!.isEmpty){

              JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
              jsonMessage.tag=Constants.routesNotAvailable;
              webSocketListener.onMessage(jsonEncode(jsonMessage));
            }else{

              var routesList=response.routes!.removeLast();

              // for (DirectionsRoute route in routesList) {
              OverviewPolyline? path = routesList.overviewPolyline;
              PolyLineLib.PolylinePoints polylinePoints = PolyLineLib.PolylinePoints();
              List<PolyLineLib.PointLatLng> result = polylinePoints.decodePolyline(path?.points ?? "");
              var latlngList=result.map((pointLatLng) => LatLng(pointLatLng.latitude,pointLatLng.longitude));
              pickUpPath.addAll(latlngList);
              //}

              JsonMessage jsonMessage=JsonMessage(tag: '', data: []);

              webSocketListener.onMessage(jsonEncode(jsonMessage));

            }

          } else {

            JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
            jsonMessage.tag=Constants.errorInRouteFinding;
            webSocketListener.onMessage(jsonEncode(jsonMessage));

          }
        });

  }

  startMovingToPickupLocation(LatLng pickup,LatLng drop, WebSocketListener webSocketListener){

    int pathIndex=1;
    int pathLength=pickUpPath.length;
    List<LatLng> dataList= <LatLng>[];
    Timer.periodic(Duration(seconds: 1), (timer) {

      var latlng=pickUpPath[pathIndex];
      dataList.add(latlng);
      JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
      jsonMessage.tag=Constants.arrivingToPickup;
      jsonMessage.data=dataList;
      webSocketListener.onMessage(jsonEncode(jsonMessage));

      if(pathIndex==pathLength-1){
        timer.cancel();
        JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
        jsonMessage.tag=Constants.captonArrived;
        jsonMessage.data=dataList;
        webSocketListener.onMessage(jsonEncode(jsonMessage));
      }
      dataList.clear();

      pathIndex++;

    });
  }


  onStartTrip( LatLng pickUpLocation, LatLng dropLocation, WebSocketListener webSocketListener) {

    //DirectionsService.init(Constants.kGoogleApiKey);

    final directinosService = DirectionsService();

    final request = DirectionsRequest(
      origin: "${pickUpLocation.latitude} ${pickUpLocation.longitude}",
      destination: "${dropLocation.latitude} ${dropLocation.longitude}",
      travelMode:google_dir.TravelMode.driving,
    );

    pickUpPath.clear();

    directinosService.route(request,
            (DirectionsResult response, DirectionsStatus? status) {
          if (status == DirectionsStatus.ok) {

            if(response.routes!.isEmpty){

              JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
              jsonMessage.tag=Constants.routesNotAvailable;
              webSocketListener.onMessage(jsonEncode(jsonMessage));
            }else{

              var routesList=response.routes!.removeLast();


              OverviewPolyline? path = routesList.overviewPolyline;
              PolyLineLib.PolylinePoints polylinePoints = PolyLineLib.PolylinePoints();
              List<PolyLineLib.PointLatLng> result = polylinePoints.decodePolyline(path?.points ?? "");
              var latlngList=result.map((pointLatLng) => LatLng(pointLatLng.latitude,pointLatLng.longitude));
              pickUpPath.addAll(latlngList);

              JsonMessage jsonMessage=JsonMessage( data: [], tag: '');

              webSocketListener.onMessage(jsonEncode(jsonMessage));

              Timer.periodic(Duration(seconds: 10), (timer) {
                startMovingToDestinationLocation(webSocketListener);
                timer.cancel();
              });
            }

          } else {

            JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
            jsonMessage.tag=Constants.errorInRouteFinding;
            webSocketListener.onMessage(jsonEncode(jsonMessage));

          }
        });
  }

  startMovingToDestinationLocation(WebSocketListener webSocketListener){

    int pathIndex=1;
    int pathLength=pickUpPath.length;
    List<LatLng> dataList= <LatLng>[];
    Timer.periodic(Duration(seconds: 1), (timer) {

      var latlng=pickUpPath[pathIndex];
      dataList.add(latlng);
      JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
      jsonMessage.tag=Constants.movingToDestTrip;
      jsonMessage.data=dataList;
      webSocketListener.onMessage(jsonEncode(jsonMessage));

      if(pathIndex==pathLength-1){
        timer.cancel();
        JsonMessage jsonMessage=JsonMessage(tag: '', data: []);
        jsonMessage.tag=Constants.destArrivedTrip;
        jsonMessage.data=dataList;
        webSocketListener.onMessage(jsonEncode(jsonMessage));
      }
      dataList.clear();

      pathIndex++;

    });
  }

}