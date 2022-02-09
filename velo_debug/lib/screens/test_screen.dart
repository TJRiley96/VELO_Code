import 'package:velo_debug/components/read_file.dart';
import 'package:velo_debug/globals.dart' as globals;

import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class TestScreen extends StatefulWidget {
  final Reading file = Reading();
 /* void _setup(){
    for(int i = 0; i < 10; i++){data.add('?');}
  }*/
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<String> data = <String>[];
  /*TestScreenState(){

    });
  }*/
  @override
  void initState() {
    // TODO: implement initState
    widget.file.readFromFile().then((value) {
      setState(() {
        data = value;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose

  }

  @override
  Widget build(BuildContext context) {
    _formatData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Values Recieved"),
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            widget.file.readFromFile().then((value){
              setState(() {
                data = value;
              });
            });

        },
        tooltip: "Refresh Data",
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
  Future<List<String>> _formatData(){
    setState(() {
    });
    return widget.file.readFromFile();
  }

  Widget _buildContent() {
    _formatData();
    //print("Global: " + globals.getData().join(',').toString());
    print("Data: " + data.join(','));
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
            "              TIME: " + data[0] + "s",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "      VOLTAGE: " + data[1] + "V",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "BATTERY(%): " + data[2] + "%",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "           X-Axis: " + data[3],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "           Y-Axis: " + data[4],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "           Z-Axis: " + data[5],
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "               Flex: " + data[6],
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
