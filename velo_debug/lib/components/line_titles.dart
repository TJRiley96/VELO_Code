import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class LineTitles{
  static getTitleData() => FlTitlesData(
    show: true,
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );
}
class HorizontalLineSetup{
  static getLineSetupData() => HorizontalLineLabel(
    padding: EdgeInsets.all(1),


  );


}