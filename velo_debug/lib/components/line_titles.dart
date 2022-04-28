import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineTitles{
  static getTitleData() => FlTitlesData(
    show: true,
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );
}
class HorizontalLineSetup{
  static getLineSetupData(context) => HorizontalLineLabel(
    style: TextStyle(color: Theme.of(context).accentColor),
    padding: EdgeInsets.all(1),
  );


}
class VerticalLineSetup{
  static getLineSetupData(context) => VerticalLineLabel(
    style: TextStyle(color: Theme.of(context).accentColor),
    padding: EdgeInsets.all(1)
  );
}