import 'package:charts_flutter/flutter.dart' as charts;

class PriceChartItem {
  final double date;
  final double price;
  final charts.Color barColor;

  PriceChartItem({ required this.date, required this.price, required this.barColor });
}