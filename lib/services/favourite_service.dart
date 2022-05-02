import 'dart:convert';

import 'package:volga_it/models/company_base.dart';

import 'file_service.dart';

class FavouriteService {
  late FileService _fileService;

  FavouriteService() {
    _fileService = FileService("favourite-items.json");
  }

  Future<void> addItem(CompanyBase item) async {
    List<CompanyBase> itemsList = await getItemsList();
    bool isItemExists = itemsList.any((element) => element.symbol == item.symbol);

    if (!isItemExists) {
      itemsList.add(item);
    }

    _fileService.writeJsonToFile(jsonEncode(itemsList));
  }

  Future<void> deleteItem(CompanyBase item) async {
    List<CompanyBase> itemsList = await getItemsList();
    itemsList.removeWhere((element) => element.symbol == item.symbol);
    _fileService.writeJsonToFile(jsonEncode(itemsList));
  }

  Future<List<CompanyBase>> getItemsList() async {
    var fileString = await _readItems();
    var result = jsonDecode(fileString) as List;
    return result.map((e) => CompanyBase.fromJson(e)).toList();
  }

  Future<String> _readItems() async {
    return await _fileService.readJsonFromFile();
  }
}