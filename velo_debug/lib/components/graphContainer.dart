import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/line_titles.dart';
import 'package:velo_debug/components/size_config.dart';
import 'package:velo_debug/globals.dart' as globals;

class GraphContainer extends StatelessWidget {
  List<List<double>> data = [];
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0)
      ),
          alignment: Alignment.centerLeft,
          constraints: BoxConstraints(maxHeight: size.safeBlockVertical*65.0, maxWidth: size.safeBlockHorizontal*70),
      child:SizedBox(
          height: size.safeBlockVertical*60.0,
          width: size.safeBlockVertical*65.0,
            child: _buildGraph(context)
      ),
    );
  }
  Future<void> graphSpots() async {
    data = await loadList();
  }
  Widget _buildGraph(context) {
    final List<FlSpot> list2 = <FlSpot>[];
    graphSpots();
    data.forEach((element) {list2.add(FlSpot(element[0], element[1])); });
    return LineChart(
      LineChartData(
        backgroundColor: Theme.of(context).primaryColor,
          minX: 0,
          minY: -5,
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
                spots: <FlSpot>[
                  FlSpot(0, 0),
                  FlSpot(10, 4.5),
                  FlSpot(20, 0),
                  FlSpot(30, -3),
                  FlSpot(40, 1),
                  FlSpot(50, 4),
                  FlSpot(60, 0),



                ]
            ),
          ]),
    );
  }

  Widget _buildContent(context) {
    var sizeConfig = SizeConfig(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
        height: sizeConfig.safeBlockVertical * 65.0,
        child:  _buildGraph(context),
      ),
    );
  }
}
Future<List<List<double>>> loadList() async {
  List<List<double>> data = await globals.loadGraph();
  List<List<double>> graphAcl = [];
  data.sort((a,b)=> b[1].compareTo(a[1]));
  int len = data.length;
  if(len >10){
    len = 10;
  }
  for(int i = 0; i < len; i++){
    graphAcl.add(data[i]);
  }
  graphAcl.sort((a, b) => a[0].compareTo(b[0]));
  print("data recived");
  print(graphAcl);
  return graphAcl;

}
