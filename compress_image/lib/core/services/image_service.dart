import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_image_compress/flutter_image_compress.dart';

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

  static Future<XFile> compressImage({
    required File imageFile,
    int quality=60,
  }) async {
    final String targetPath = p.join(Directory.systemTemp.path, 'tempimage.${CompressFormat.jpeg.name}');
    final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      quality: quality,
    );

    if (compressedImage==null){
      throw ("Failed to compress the image");
    }

    return compressedImage;
  }

}