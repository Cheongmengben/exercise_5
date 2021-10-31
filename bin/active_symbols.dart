import 'dart:convert';
import 'package:web_socket_channel/io.dart';

void main(List<String> arguments) {
   final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');      //connect to the server 

  channel.stream.listen((tick){
    final decodedMessage = jsonDecode(tick);         //decode the message requested from the server side
    final name = decodedMessage['tick']['symbol'];  
    final price = decodedMessage['tick']['quote'];
    final date = decodedMessage['tick']['epoch'];   //taking only the time variable into it
    final serverTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);     //*1000 (milliseconds to seconds?)
    print('name:$name, price:$price Time:$serverTime');

  
  });

  channel.sink.add('{"ticks": "frxAUDCAD","subscribe": 1}');       //send data to server
 }
