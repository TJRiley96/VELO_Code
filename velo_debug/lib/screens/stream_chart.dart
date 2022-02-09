import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';
import 'package:velo_debug/globals.dart' as globals;
class StreamChart extends StatelessWidget {
  //final String initData = "";
  double _count = 0;
  final List<FlSpot> dotList = <FlSpot>[];
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
        Duration(milliseconds: 100),
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

  Widget _buildChart(context, snapshot) {
    final List<String> data = globals.parseData(snapshot);
    final FlSpot temp = FlSpot(_count, (double.parse(data[5]) * 0.1));
    dotList.add(temp);
    print(dotList);
    print(dotList.length);
    _count++;
    return LineChart(
      LineChartData(
          minX: 0,
          minY: -2,
          maxX: double.parse(data[0]),
          maxY: 2,
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
          lineBarsData: [
            LineChartBarData(
                dotData: FlDotData(show: false),
                barWidth: 3,
                isCurved: true,
                spots: dotList,
            ),
          ]),
    );
  }
}
