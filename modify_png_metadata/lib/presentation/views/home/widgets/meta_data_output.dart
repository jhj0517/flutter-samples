import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modify_png_metadata/core/services/png_chunk_service.dart';
import 'package:modify_png_metadata/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class MetaDataOutput extends StatelessWidget {

  const MetaDataOutput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = context.select<HomeProvider, List<Map<String, dynamic>>?>((provider) => provider.chunks);
    if (metadata == null || metadata.isEmpty) {
      return const Text(
        "No metadata available",
        style: TextStyle(fontSize: 20, color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Metadata Inspector",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Length')),
              DataColumn(label: Text('Data')),
            ],
            rows: metadata.map((chunk) {
              final type = chunk['name'];
              final data = chunk['data'];
              final length = data.length;

              String displayData;
              switch(type){
                case 'tEXt':
                  final tEXt = PngChunkService.gettEXt(chunk: metadata)![0];
                  displayData = "keyword : ${tEXt['keyword']}\nText String : ${tEXt['data']}";
                default:
                  if (length>10) {
                    displayData =  '[${data.take(10).join(", ")} .... ]';
                  } else {
                    displayData = data.toString();
                  }
              }

              return DataRow(cells: [
                DataCell(Text(type)),
                DataCell(Text(length.toString())),
                DataCell(Text(displayData)),
              ]);
            }).toList(),
          ),
        )
      ],
    );
  }
}
