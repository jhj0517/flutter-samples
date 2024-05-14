import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:png_chunks_encode/png_chunks_encode.dart' as pngEncode;
import 'package:png_chunks_extract/png_chunks_extract.dart' as pngExtract;

class ChunkRepository{

  static List<Map<String, dynamic>>? readChunk({
    required Uint8List BLOB
  }) {
    try{
      return pngExtract.extractChunks(BLOB);
    } catch(e){
      return null;
    }
  }

}