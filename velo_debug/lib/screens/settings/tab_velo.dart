import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';
import 'package:velo_debug/components/size_config.dart';
import 'package:velo_debug/screens/bluetooth/ble_notify.dart';
import 'package:velo_debug/screens/bluetooth/ble_stream.dart';

import 'package:velo_debug/globals.dart' as globals;

class VeloTab extends StatefulWidget {
  VeloTab({Key? key}) : super(key: key);

  @override
  _VeloTabState createState() => _VeloTabState();
}

class _VeloTabState extends State<VeloTab> {
  double _count = 0;
  double _maxY = 5;
  double _minY = -5;

  final List<FlSpot> dotList = <FlSpot>[];

  final List<FlSpot> dotList2 = <FlSpot>[];
  final List<FlSpot> dotList3 = <FlSpot>[];

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig(context);
    return _buildGraph(context);
  }

  Widget _buildGraph(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: StreamBuilder<List<String>>(
        stream: BLENotify(d: globals.getDevice()).stream,
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.waiting) ||
              !snapshot.hasData) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("ERROR!"),
            );
          } else {
            final data = snapshot.data!;
            if (data.isNotEmpty) {
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        //child: _buildChart(context, data),
                        text: "One Chart",
                      ),
                      Tab(
                        //child: _buildTab2(context, data),
                        text: "Multi Chart",
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [_buildChart(context, data), _buildTab2(context, data)],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  void _addToList(List<FlSpot> dot, FlSpot data) {
    dot.add(data);
    print(dot);
    print(dot.length);
  }

  List<LineChartBarData> get lineBarsData1 =>
      [lineChartBarData1_1, lineChartBarData1_2, lineChartBarData1_3];

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

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xfffc5a03)],
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: dotList3,
      );

  Widget _buildChart(context, data) {
    //print("      Data       \n===================\n$snapshot\n===============");
    final List<String> data1 = globals.parseData(data[0]);
    if (data1.isNotEmpty) {
      double acl = double.parse(data1[0]) * (-1);
      double ori = double.parse(data1[1]);
      double flx = double.parse(data1[2]);

      if (ori < 0.0) {
        ori += 180.0;
      } else if (ori > 0.0) {
        ori -= 180.0;
      } else {
        ori = 0.0;
      }
      final FlSpot temp1 = FlSpot(_count, acl);
      final FlSpot temp2 = FlSpot(_count, ori);
      final FlSpot temp3 = FlSpot(_count, flx);
      if ((acl > _maxY) || (acl < _minY) || (ori > _maxY) || (ori < _minY)) {
        if (ori > _maxY) {
          _maxY = ori;
        } else if (ori < _minY) {
          _minY = ori;
        } else if (acl > _maxY) {
          _maxY = acl;
        } else if (acl < _minY) {
          _minY = acl;
        }
      }

      _addToList(dotList, temp1);
      _addToList(dotList2, temp2);
      _addToList(dotList3, temp3);
      globals.appendFile(_count, acl, ori, flx);
      _count++;
    }

    return LineChart(
      LineChartData(
        backgroundColor: Theme.of(context).primaryColor,
        minX: (_count - 60),
        minY: _minY,
        maxX: _count,
        maxY: _maxY,
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

  Widget _buildOri(context, data) {
    //print("      Data       \n===================\n$snapshot\n===============");
    final List<String> data1 = globals.parseData(data[0]);
    if (data1.isNotEmpty) {
      double acl = double.parse(data1[0]) * (-1);
      double ori = double.parse(data1[1]);
      double flx = double.parse(data1[2]);

      if (ori < 0.0) {
        ori += 180.0;
      } else if (ori > 0.0) {
        ori -= 180.0;
      } else {
        ori = 0.0;
      }
      final FlSpot temp1 = FlSpot(_count, acl);
      final FlSpot temp2 = FlSpot(_count, ori);
      final FlSpot temp3 = FlSpot(_count, flx);
      if ((acl > _maxY) || (acl < _minY) || (ori > _maxY) || (ori < _minY)) {
        if (ori > _maxY) {
          _maxY = ori;
        } else if (ori < _minY) {
          _minY = ori;
        } else if (acl > _maxY) {
          _maxY = acl;
        } else if (acl < _minY) {
          _minY = acl;
        }
      }

      _addToList(dotList, temp1);
      _addToList(dotList2, temp2);
      _addToList(dotList3, temp3);
      globals.appendFile(_count, acl, ori, flx);
      _count++;
    }

    return LineChart(
      LineChartData(
        backgroundColor: Theme.of(context).primaryColor,
        minX: (_count - 60),
        minY: _minY,
        maxX: _count,
        maxY: _maxY,
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
        lineBarsData: [lineChartBarData1_1],
      ),
    );
  }

  Widget _buildTab2(context, data) {
    return SizedBox(
      height: 500,
      width: 600,
      child: Column(
        children: [_buildACL(context, data), _buildOri(context, data)],
      ),
    );
  }

  Widget _buildACL(context, data) {
    //print("      Data       \n===================\n$snapshot\n===============");
    final List<String> data1 = globals.parseData(data[0]);
    if (data1.isNotEmpty) {
      double acl = double.parse(data1[0]) * (-1);

      final FlSpot temp1 = FlSpot(_count, acl);
      if (acl > _maxY) {
        _maxY = acl;
      } else if (acl < _minY) {
        _minY = acl;
      }

      _addToList(dotList, temp1);
      _count++;
    }

    return LineChart(
      LineChartData(
        backgroundColor: Theme.of(context).primaryColor,
        minX: (_count - 60),
        minY: _minY,
        maxX: _count,
        maxY: _maxY,
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
        lineBarsData: [lineChartBarData1_2],
      ),
    );
  }
}
