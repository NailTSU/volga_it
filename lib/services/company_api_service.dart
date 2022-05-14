import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:volga_it/components/price_history.dart';
import 'package:volga_it/constants/api.dart';
import 'package:volga_it/models/company_info.dart';
import 'package:volga_it/models/price_chart_item.dart';
import 'package:volga_it/models/quote_price.dart';
import 'package:volga_it/services/api_service.dart';

class CompanyApiService {
  Future<CompanyInfo> getCompanyBySymbol(String symbol) async {
    var response = await ApiService.get('${Api.profile}?symbol=$symbol');
    try {
      var company = CompanyInfo.fromJson(jsonDecode(response));
      company.quotePrice = await getQuotePrice(symbol);
      return company;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getQuotePrice(String symbol) async {
    var query = symbol.split('.')[0];
    var response = await ApiService.get('${Api.quote}?symbol=$query');
    return QuotePrice.fromJson(jsonDecode(response)).c.toString();
  }

  PriceChartItem getPriceCharItem(int index, double item, DateTime currentDate) {
    var date = DateTime(currentDate.year, currentDate.month, currentDate.day - index);
    var stringDate = '${date.month}.${date.day}';
    return PriceChartItem(date: double.parse(stringDate), price: item, barColor: charts.Color.black);
  }

  Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }
}