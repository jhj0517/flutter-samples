import 'package:flutter/material.dart';
import 'package:modify_png_metadata/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class MetaDataOutput extends StatelessWidget {

  const MetaDataOutput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = context.select<HomeProvider, List<Map<String, dynamic>>?>((provider) => provider.metadata);
    return Text(
      "$metadata",
      style: const TextStyle(fontSize: 20, color: Colors.grey),
    );
  }
}
