import 'dart:convert';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ura_taxi/simulator/simulator.dart';
import 'package:ura_taxi/simulator/web_socket_listener.dart';

import '../utils/constants.dart';
import 'json_message.dart';

class WebSocket{

 late WebSocketListener webSocketListener;
  late Simulator _simulator;

  static const String TAG= "WebSocket";

  WebSocket(WebSocketListener webSocketListener){
    this.webSocketListener=webSocketListener;
  }

  connect(){
    webSocketListener.onConnect();
    _simulator=Simulator();
  }

  sendMessage(String data){

    log('$TAG: $data');

    Map<String, dynamic> map = jsonDecode(data);

    JsonMessage msg=JsonMessage.fromJson(map);

    if(msg.tag==Constants.nearByCabs){

      //msg.data=(msg.data as List<LatLng>).map((e) => LatLng(e.latitude,e.longitude)).toList();

      var latlng =msg.data.removeAt(0);

      _simulator.getFakeNearByCabs(latlng!, webSocketListener);

    }else if (msg.tag==Constants.requestForCab){

      var dropLat=msg.data.removeAt(1);
      var pickLat=msg.data.removeAt(0);


      _simulator.requestCab(pickLat!,dropLat!, webSocketListener);

    }else if(msg.tag==Constants.confirmPickUp){

      var dropLat=msg.data.removeAt(1);
      var pickLat=msg.data.removeAt(0);
      _simulator.startMovingToPickupLocation(pickLat!,dropLat!, webSocketListener);

    }else if(msg.tag==Constants.onStartTrip){

      var dropLat=msg.data.removeAt(1);
      var pickLat=msg.data.removeAt(0);
      _simulator.onStartTrip(pickLat!,dropLat!, webSocketListener);

    }

  }

  disconnect() {
    //Simulator.stopTimer()
    this.webSocketListener.onDisconnect();
  }

}