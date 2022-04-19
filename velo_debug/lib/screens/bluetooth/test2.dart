import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class DeviceTest2 extends StatefulWidget {
  DeviceTest2({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<DeviceTest2> createState() => _DeviceTest2State();
}

class _DeviceTest2State extends State<DeviceTest2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: widget.device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => widget.device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => widget.device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body:Center(child: _buildStreams()),
    );
  }

  Widget _buildScreen(){
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[],
            )
          );

  }

  Widget _buildStreams(){
    return StreamBuilder<List<String>>(
      stream: TestAgain(d: widget.device).stream,
      builder: (c, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("No Data Yet.");
        } else if(snapshot.hasError){
          return Text("ERROR!!");
        } else{
          List<String> data = snapshot.data as List<String>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Stats\n${data[0]}"),
              Text("Orientation\n${data[1]}"),
              Text("Flex\n${data[2]}"),
            ],
          );
              ;
        }
      },
    );
  }
}
class Character{
  Character({required this.value});
  final List<int> value;

  String getValue(){return utf8.decode(value);}
  void printValue(){
    print("Raw Value: $value");

  }
}
class TestAgain{
  TestAgain({required this.d}){
    process();
    Stream.periodic(Duration(seconds: 1), (t) {
      _controller.sink.add(str);
    });
  }

  final BluetoothDevice d;
  final _controller = StreamController<List<String>>();
  List<String> str = [];
  Stream<List<String>> get stream => _controller.stream;

  Future<void> process() async{
    List<BluetoothService> services = await d.discoverServices();
    BluetoothService velo = services.last;
    var value1 = await velo.characteristics[1].read();
    var value2 = await velo.characteristics[2].read();
    var value3 = await velo.characteristics[3].read();
    str.insert(0, utf8.decode(value1));
    str.insert(1, utf8.decode(value2));
    str.insert(2, utf8.decode(value3));
    print(str);
  }

}
