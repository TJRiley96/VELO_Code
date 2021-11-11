import 'package:flutter/material.dart';

class TestBluetooth extends StatefulWidget {
  @override
  _TestBluetoothState createState() => _TestBluetoothState();
}

class _TestBluetoothState extends State<TestBluetooth> {
  final _dataInput = <String>[];
  final _valueIndicators = <String>['Time started: ', 'Voltage: ', 'Battery: ', 'Stretch: ', 'Resistance: '];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Data Received'),
      ),
      body: Text("This is were data will be put\n"
          "More Text\n"
          "Even More text"),
    );
  }
  Widget _buildDataSet(){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Data Received'),
      ),
    );
  }
  Widget _buildRow(){
    return _buildList();
  }
  Widget _buildList(){
    return Text('data');
  }
}
