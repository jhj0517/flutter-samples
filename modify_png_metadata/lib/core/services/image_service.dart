import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:png_chunks_encode/png_chunks_encode.dart' as pngEncode;

class ImageService{

  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }

  static Future<Uint8List> toBLOB({
    required File imageFile
  }) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    return imageBytes;
  }

  static Future<void> saveToGallery({
    required String filePath,
  }) async {
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    String fileName = "Modify_PNG_Metadata_Sample_$timestamp";
    await ImageGallerySaver.saveFile(
      filePath,
      name: fileName,
    );
  }

  static Future<void> saveWithChunk({
    required List<Map<String, dynamic>> chunk,
  }) async {
    final newBuffer = pngEncode.encodeChunks(chunk);
    final file = File(p.join(Directory.systemTemp.path, 'tempimage.png'));
    await file.create();
    await file.writeAsBytes(newBuffer);

    await saveToGallery(filePath: file.path);
  }

}