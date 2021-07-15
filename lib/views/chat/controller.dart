import 'package:web_socket_channel/io.dart';

class ChatController {

  static const String _CHANNEL_ID = 'wss://echo.websocket.org';
  IOWebSocketChannel channel;

  Future<void> connect()async => channel = IOWebSocketChannel.connect(_CHANNEL_ID);

  void sendMessage(String message)async{
    channel.sink.add(message);
  }

  void disconnect() => channel.sink.close();

}