import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:png_chunks_encode/src/etc32.dart';
import 'package:png_chunks_extract/png_chunks_extract.dart' as pngExtract;

class PngChunkService{

  static List<Map<String, dynamic>>? read({
    required Uint8List BLOB
  }) {
    try{
      return pngExtract.extractChunks(BLOB);
    } catch(e){
      debugPrint("Reading Chunk Failed $e");
      return null;
    }
  }

  static List<Map<String, dynamic>>? gettEXt({
    required List<Map<String, dynamic>> chunk
  }) {
    List<Map<String, dynamic>> tEXt = chunk.where((c) => c["name"]=="tEXt").toList();
    if (tEXt.isEmpty){
      return null;
    }

    final decoded = utf8.decode(tEXt[0]["data"]);
    tEXt[0]["data"] = decoded;
    return tEXt;
  }


  static List<Map<String, dynamic>> addtEXt({
    required List<Map<String, dynamic>> chunk,
    required String text,
  }) {
    List<int> newData = [...utf8.encode(text)];

    Uint8List chunkType = Uint8List.fromList(utf8.encode('tEXt'));
    Uint8List dataBytes = Uint8List.fromList(newData);
    Uint8List crcInput = Uint8List.fromList([...chunkType, ...dataBytes]);
    int crc = Crc32.getCrc32(crcInput);

    Map<String, dynamic> tEXtChunk = {
      'name': 'tEXt',
      'data': dataBytes,
      'crc': crc
    };

    int end = chunk.indexWhere((chunk) => chunk['name'] == 'IEND');
    chunk.insert(end, tEXtChunk);
    return chunk;
  }

}