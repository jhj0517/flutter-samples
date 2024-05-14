import 'package:flutter/material.dart';

class MetaDataOutput extends StatelessWidget {
  final String? metadata;

  const MetaDataOutput({
    super.key,
    required this.metadata,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      metadata?? "",
      style: const TextStyle(fontSize: 20, color: Colors.grey),
    );
  }
}
