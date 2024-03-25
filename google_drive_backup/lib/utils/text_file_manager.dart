import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<io.File> getTextFile() async {
  final directory = await getTemporaryDirectory();
  final filePath = join(directory.path, "myTextFile.txt");
  return io.File(filePath);
}

Future<void> writeTextFile(String text) async {
  final file = await getTextFile();
  await file.writeAsString(text);
}

Future<String> readTextFile() async {
  final file = await getTextFile();

  final exist = await file.exists();
  if (!exist){
    return "";
  }

  return await file.readAsString();
}