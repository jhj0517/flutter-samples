import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import 'package:modify_png_metadata/core/services/image_service.dart';
import 'package:modify_png_metadata/core/services/png_chunk_service.dart';


class HomeProvider extends ChangeNotifier {

  HomeProvider();

  File? _image;
  File? get image => _image;

  List<Map<String, dynamic>>? _chunk;
  List<Map<String, dynamic>>? get chunk => _chunk;


  Future<bool> pickImage() async {
    final pickedFile = await ImageService.pickImage();

    final mime = lookupMimeType(pickedFile?.path ?? "");
    if (mime == null || !mime.startsWith("image/png")) {
      return false;
    }

    if (pickedFile != null) {
      _image = pickedFile;
      notifyListeners();

      final blob = await ImageService.toBLOB(imageFile: pickedFile);
      final chunk = PngChunkService.read(BLOB: blob);
      _chunk = chunk;
      notifyListeners();
      return true;
    }

    return false;
  }

}