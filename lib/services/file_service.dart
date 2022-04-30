import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  final String fileName;

  FileService(this.fileName);

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  Future<File> writeJsonToFile(String json) async {
    final file = await _localFile;

    if (!(await file.exists())) {
      file.create();
    }

    return file.writeAsString(json);
  }

  Future<String> readJsonFromFile() async {
    final file = await _localFile;

    if (!(await file.exists())) {
      file.create();
      file.writeAsString(jsonEncode([]));
    }

    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      throw Exception("Не удалось считать файл");
    }
  }
}