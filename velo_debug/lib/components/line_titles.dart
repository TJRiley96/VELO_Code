import 'package:fl_chart/fl_chart.dart';

class LineTitles{
  static getTitleData() => FlTitlesData(
    show: true,
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );
}