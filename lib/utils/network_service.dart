import '../simulator/web_socket.dart';
import '../simulator/web_socket_listener.dart';

class NetworkService{

  WebSocket  createWebSocket(WebSocketListener webSocketListener)  {
    return WebSocket(webSocketListener);
  }

}