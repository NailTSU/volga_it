import 'dart:convert';
import 'dart:developer';

import 'package:volga_it/constants/api.dart';
import 'package:volga_it/models/company_info.dart';
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
      log(e.toString());
      rethrow;
    }
  }

  Future<String> getQuotePrice(String symbol) async {
    var query = symbol.split('.')[0];
    var response = await ApiService.get('${Api.quote}?symbol=$query');
    log(response);
    return QuotePrice.fromJson(jsonDecode(response)).c.toString();
  }
}