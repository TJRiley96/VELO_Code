import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';

class GraphContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(context),
    );
  }

  Widget _buildGraph(context) {
    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: 60,
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
          lineBarsData: [
            LineChartBarData(
                dotData: FlDotData(show: false),
                barWidth: 3,
                isCurved: true,
                spots: [
                  FlSpot(0, 0),
                  FlSpot(1, 1),
                  FlSpot(3, 1.5),
                  FlSpot(6, 3.5),
                  FlSpot(11, 2.5),
                  FlSpot(25, 0.5),
                  FlSpot(30, 2),
                  FlSpot(40, 3.5),
                  FlSpot(50, 4.5),
                ]),
          ]),
    );
  }

  Widget _buildContent(context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
        height: 500,
        child: _buildGraph(context),
      ),
    );
  }
}
