import 'dart:convert';

import 'package:volga_it/constants/api.dart';
import 'package:volga_it/models/company.dart';
import 'package:volga_it/services/api_service.dart';

class SearchApiService {
  Future<List<Company>> getCompaniesList(String query) async {
    var response = await ApiService.get('${Api.search}?q=$query');
    var resultJson = jsonDecode(response)["result"] as List;
    var companiesList = resultJson.map((e) => Company.fromJson(e)).where((element) => element.type != '').toList();
    var rangeEnd = companiesList.length > 10 ? 10 : companiesList.length;
    return companiesList.sublist(0, rangeEnd);
  }
}