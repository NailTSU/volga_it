import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:volga_it/constants/api.dart';

class ApiService {
  static final Map<String, String> headers = {
    'X-Finnhub-Token': Api.apiKey
  };

  static Future<String> get(String url) async {
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Не удалось получить список компаний');
    }
  }
}