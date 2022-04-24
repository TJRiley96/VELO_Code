

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';
import 'package:velo_debug/screens/bluetooth/ble_notify.dart';
import 'package:velo_debug/screens/bluetooth/ble_stream.dart';

import 'package:velo_debug/globals.dart' as globals;

class VeloGraph extends StatefulWidget {
  VeloGraph({Key? key}) : super(key: key);

  @override
  _VeloGraphState createState() => _VeloGraphState();
}

class _VeloGraphState extends State<VeloGraph> {
  double _count = 0;
  double _maxY = 5;
  double _minY = 5;

  final List<FlSpot> dotList = <FlSpot>[];

  final List<FlSpot> dotList2 = <FlSpot>[];

  @override
  Widget build(BuildContext context) {
    return _buildGraph();
  }

  Widget _buildGraph(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Battery Chart"),
      ),
      body: StreamBuilder<List<String>>(
        stream: BLENotify(d: globals.getDevice()).stream,
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.waiting) || !snapshot.hasData) {
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Center(
              child: Text("ERROR!"),
            );
          }else {
            return Center(
                child:SizedBox(
                  height: 500,
                  width: 600,
                  child: _buildChart(context, snapshot.data),
                )
            );
          }
        },
      ),
    );
  }

  void _addToList(List<FlSpot> dot, FlSpot data){
    dot.add(data);
    print(dot);
    print(dot.length);
  }

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    colors: [const Color(0xff5b9ed7)],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: dotList,
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    colors: [const Color(0xff4af699)],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: dotList2,
  );

  Widget _buildChart(context, data) {

    //print("      Data       \n===================\n$snapshot\n===============");
    final List<String> data1 = globals.parseData(data[0]);
    if(data1.isNotEmpty) {
      final FlSpot temp1 = FlSpot(_count, double.parse(data1[0]));
      final FlSpot temp2 = FlSpot(_count, double.parse(data1[1]));
      if(double.parse(data1[2]) > _maxY){
        _maxY = double.parse(data1[2]);
      } else if (double.parse(data1[2]) < _minY){
        _minY = double.parse(data1[2]);
      }
      _addToList(dotList, temp1);
      _addToList(dotList2, temp2);
    }
    _count++;
    return LineChart(
      LineChartData(
        minX: (_count - 60),
        minY: -5,
        maxX: _count,
        maxY: 5,
        titlesData: LineTitles.getTitleData(),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white,
              strokeWidth: 3,
            );
          },
          drawVerticalLine: false,
        ),
        lineBarsData: lineBarsData1,
      ),
    );
  }
}
