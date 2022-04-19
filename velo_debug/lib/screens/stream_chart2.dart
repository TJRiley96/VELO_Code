 import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';
import 'package:velo_debug/globals.dart' as globals;
class StreamChartAgain extends StatelessWidget {
  //final String initData = "";
  double _count = 0;
  final List<FlSpot> dotList = <FlSpot>[];
  final List<FlSpot> dotList2 = <FlSpot>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder Version"),
      ),
      body: StreamBuilder<String>(
        stream: getStringData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Center(
            child: _buildChart(context, snapshot.data.toString()),
          );
        },
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Stream<String> getStringData() =>
      Stream<String>.periodic(
        Duration(milliseconds: 100 ),
            (value) => globals.getStringData(),
      );

  Widget _buildContent(context, snapshot) {
    final List<String> data = globals.parseData(snapshot);
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
        ],
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
  Widget _buildChart(context, snapshot) {

    //print("      Data       \n===================\n$snapshot\n===============");
    final List<String> data1 = globals.parseData(snapshot);
    if(data1.isNotEmpty) {
      final FlSpot temp1 = FlSpot(_count, double.parse(data1[5]));
      final FlSpot temp2 = FlSpot(_count, double.parse(data1[6]));
      _addToList(dotList, temp1);
      _addToList(dotList2, temp2);
    }
    _count++;
    return LineChart(
      LineChartData(
          minX: _count - 60,
          minY: -30,
          maxX: _count,
          maxY: 30,
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
