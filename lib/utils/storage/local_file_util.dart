import 'dart:io';

import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:path_provider/path_provider.dart';

/// https://docs.flutter.dev/cookbook/persistence/reading-writing-files
class LocalFileUtil with Log4Dart {
  Future<String> _getLocalDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getLocalFile(String fileName) async {
    final String path = await _getLocalDocumentsPath();
    return File('$path/$fileName');
  }

  // TODO: Fix multiple access on file
  Future<File> writeStringToFile(String fileName, String data) async {
    final File file = await _getLocalFile(fileName);
    logDebug('Writing to file: ${file.path}, Data: $data');
    return file.writeAsString(data);
  }

  Future<void> listAllFiles() async {
    final String path = await _getLocalDocumentsPath();
    List<FileSystemEntity> files = Directory("$path/").listSync();
    for (var f in files) {
      logDebug(f.toString());
    }
  }
}
