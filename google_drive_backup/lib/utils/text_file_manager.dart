import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class LocalTextFile{
  static Future<io.File> getFile() async {
    final directory = await getTemporaryDirectory();
    final filePath = join(directory.path, "myTextFile.txt");
    return io.File(filePath);
  }

  static Future<void> writeFile(String text) async {
    final file = await getFile();
    await file.writeAsString(text);
  }

  static Future<String> readFile() async {
    final file = await getFile();

    final exist = await file.exists();
    if (!exist){
      return "";
    }

    return await file.readAsString();
  }
}
