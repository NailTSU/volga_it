import 'dart:convert';

import 'file_service.dart';

class FavouriteService {
  late FileService _fileService;

  FavouriteService() {
    _fileService = FileService("favourite-items.json");
  }

  Future<void> addItem(String item) async {
    List<String> itemsList = await getItemsList();
    Set<String> itemsSet = itemsList.toSet();
    itemsSet.add(item);
    _fileService.writeJsonToFile(jsonEncode(itemsSet.toList()));
  }

  Future<void> deleteItem(String item) async {
    List<String> itemsList = await getItemsList();
    itemsList.remove(item);
    _fileService.writeJsonToFile(jsonEncode(itemsList));
  }

  Future<List<String>> getItemsList() async {
    var fileString = await _readItems();
    var result = jsonDecode(fileString) as List;
    return List<String>.from(result);
  }

  Future<String> _readItems() async {
    return await _fileService.readJsonFromFile();
  }
}