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
    List<Map<String, dynamic>> copiedChunk = chunk.map((map) => Map<String, dynamic>.from(map)).toList();
    List<Map<String, dynamic>> tEXt = copiedChunk.where((c) => c["name"]=="tEXt").toList();
    if (tEXt.isEmpty){
      return null;
    }

    for (var item in tEXt){
      List<int> chunk = item['data'];
      final keyword = chunk.sublist(0, chunk.indexOf(0));
      final data = chunk.sublist(chunk.indexOf(0)+1);

      item["keyword"] = utf8.decode(keyword);
      item["data"] = utf8.decode(data);
    }

    return tEXt;
  }


  static List<Map<String, dynamic>> addtEXt({
    required List<Map<String, dynamic>> chunk,
    required String keyword,
    required String text,
  }) {
    List<int> tEXtData = [...utf8.encode(keyword), 0, ...utf8.encode(text)];

    Uint8List chunkType = Uint8List.fromList(utf8.encode('tEXt'));
    Uint8List dataBytes = Uint8List.fromList(tEXtData);
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