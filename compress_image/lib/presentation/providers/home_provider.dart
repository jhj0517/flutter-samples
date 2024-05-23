import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import 'package:modify_png_metadata/core/services/image_service.dart';
import 'package:modify_png_metadata/core/services/png_chunk_service.dart';


class HomeProvider extends ChangeNotifier {

  HomeProvider();

  File? _image;
  File? get image => _image;

  List<Map<String, dynamic>>? _chunks;
  List<Map<String, dynamic>>? get chunks => _chunks;

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
      _chunks = PngChunkService.read(BLOB: blob);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> saveWithMetaData({
    required String text,
  }) async {
    if (chunks==null){
      return false;
    }

    final newChunk = PngChunkService.addtEXt(chunk: chunks!, keyword: "Modify PNG Metadata", text: text);
    await ImageService.saveWithChunk(chunk: newChunk);
    notifyListeners();
    return true;
  }

}