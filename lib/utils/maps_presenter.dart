import 'dart:convert';
import 'dart:developer';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ura_taxi/utils/maps_view.dart';
import 'package:ura_taxi/utils/network_service.dart';
import '../simulator/json_message.dart';
import '../simulator/web_socket.dart';
import '../simulator/web_socket_listener.dart';
import 'constants.dart';


class MapsPresenter  implements WebSocketListener{


  late WebSocket webSocket;

  late MapsView uiView;

  static const String TAG = "MapsPresenter";

  MapsPresenter( NetworkService networkService ) {
    webSocket=networkService.createWebSocket(this);
  }

  onAttach(MapsView uiView) {
    this.uiView = uiView;
    webSocket.connect();
  }

  onDetach() {
    webSocket.disconnect();
    //uiView = null;
  }

  @override
  onConnect() {

    log('$TAG: onConnect');
  }


  showNearbyCabs(LatLng latLng) {
    JsonMessage jsonMessage=JsonMessage(data: [], tag: '');
    jsonMessage.tag=Constants.nearByCabs;
    jsonMessage.data=<LatLng>[];
    jsonMessage.data.add(latLng);
    var jsonData = jsonEncode(jsonMessage);
    webSocket.sendMessage(jsonData);
  }

  requestCab(LatLng pickLat,LatLng dropLat){

    JsonMessage jsonMessage=JsonMessage(data: [], tag: '');
    jsonMessage.tag=Constants.requestForCab;
    jsonMessage.data=<LatLng>[];
    jsonMessage.data.add(pickLat);
    jsonMessage.data.add(dropLat);
    var jsonData = jsonEncode(jsonMessage);
    webSocket.sendMessage(jsonData);


  }

  confirmPickup(LatLng pickLat,LatLng dropLat){

    JsonMessage jsonMessage=JsonMessage(data: [], tag: '');
    jsonMessage.tag=Constants.confirmPickUp;
    jsonMessage.data=<LatLng>[];
    jsonMessage.data.add(pickLat);
    jsonMessage.data.add(dropLat);
    var jsonData = jsonEncode(jsonMessage);
    webSocket.sendMessage(jsonData);


  }

  onStartTrip(LatLng pickLat,LatLng dropLat){

    JsonMessage jsonMessage=JsonMessage(data: [], tag: '');
    jsonMessage.tag=Constants.onStartTrip;
    jsonMessage.data=<LatLng>[];
    jsonMessage.data.add(pickLat);
    jsonMessage.data.add(dropLat);
    var jsonData = jsonEncode(jsonMessage);
    webSocket.sendMessage(jsonData);


  }



  @override
  onDisconnect() {
    // TODO: implement onDisconnect
    throw UnimplementedError();
  }

  @override
  onError(String error) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  onMessage(String message) {

    Map<String, dynamic> map = jsonDecode(message);
    JsonMessage obj=JsonMessage.fromJson(map);


    if(obj.tag==Constants.nearByCabs){
      uiView.showNearbyCabs(obj.data);
    }else if(obj.tag==Constants.pickUpPath){
      uiView.showPath(obj.data);
    }else if(obj.tag==Constants.arrivingToPickup){
      uiView.updateCabLocation(obj.data[0]);
    } else if(obj.tag==Constants.captonArrived){
      uiView.informCabArrived();
    }else if(obj.tag==Constants.DestinationPath) {
      uiView.showPathDest(obj.data);
    } else if(obj.tag==Constants.movingToDestTrip){
      uiView.updateCabLocationDest(obj.data[0]);
    }else if(obj.tag==Constants.destArrivedTrip){
      uiView.informTripEnd();
    }

  }

}