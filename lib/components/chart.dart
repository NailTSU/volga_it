import 'package:flutter/cupertino.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:volga_it/models/price_chart_item.dart';

class Chart extends StatelessWidget {
  final List<PriceChartItem> dataRows;

  const Chart({Key? key, required this.dataRows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PriceChartItem, num>> series = [
      charts.Series(
          id: "prices",
          data: dataRows,
          domainFn: (PriceChartItem series, _) => series.date,
          measureFn: (PriceChartItem series, _) => series.price,
          colorFn: (PriceChartItem series, _) => series.barColor
      )
    ];

    return charts.LineChart(series,
        domainAxis: const charts.NumericAxisSpec(
          tickProviderSpec:
          charts.BasicNumericTickProviderSpec(zeroBound: false),
          viewport: charts.NumericExtents(2016.0, 2022.0),
        ),
        animate: true);
  }

}