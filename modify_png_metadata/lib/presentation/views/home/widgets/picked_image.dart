import 'dart:io';
import 'package:flutter/material.dart';

class PickedImage extends StatelessWidget {
  const PickedImage({
    super.key,
    required this.image,
  });

  final File? image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: const Icon(Icons.image, size: 50, color: Colors.grey),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        image!,
        fit: BoxFit.cover,
        height: 200,
        width: 200,
      ),
    );
  }
}

