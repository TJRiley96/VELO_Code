import 'package:velo_debug/globals.dart' as globals;

import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Values Recieved"),
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(),
    );
  }
  List<dynamic> _formatData() {
    List<dynamic> data = <String>['?', '?','?','?'];

    if(globals.BLEData != '') {
      for(int i = 0; i < data.length - 1; i++) {
        data[i] = globals.BLEData.split(', ')[i];
      }
      return data;
    }

    return data;
  }

  Widget _buildContent() {
    List<dynamic> data = _formatData();
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
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "              TIME: " + data[0],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "      VOLTAGE: " + data[1],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "BATTERY(%): " + data[2],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "       FLEXION: " + data[3],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          /*Container(
            color: Colors.deepOrangeAccent,
            alignment: Alignment.center,
            child: SizedBox(
              height: 100.0,
              child: Text(""
                  "TIME: ",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 8.0,),
          Container(
            color: Colors.orange,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          SizedBox(height: 8.0,),*/
        ],
      ),
    );
  }
}
