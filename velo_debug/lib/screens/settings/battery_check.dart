import 'package:velo_debug/components/read_file.dart';
import 'package:velo_debug/globals.dart' as globals;
import 'package:velo_debug/screens/bluetooth/ble_stream.dart';
import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class BatScreen extends StatefulWidget {
  final Reading file = Reading();

  /* void _setup(){
    for(int i = 0; i < 10; i++){data.add('?');}
  }*/
  @override
  State<BatScreen> createState() => _BatScreenState();
}

class _BatScreenState extends State<BatScreen> {


  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Bluetooth Values Recieved"),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavBar(),
      body: StreamBuilder<List<String>>(
          stream: BLEStream(d: globals.getDevice()).stream,
          builder: (context, snapshot) {
            if ((snapshot.connectionState == ConnectionState.waiting) ||
                !snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ERROR!"),
              );
            } else {
              return _con(context, snapshot.data);
            }
          }
      ),
    );
  }
  Widget _con(context, data){
    return Container(
      color: Colors.black45,
      padding: EdgeInsets.all(16.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Incoming Data",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "      VOLTAGE: " + data[0] + "V",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "BATTERY(%): " + data[1] + "%",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

  }
}
