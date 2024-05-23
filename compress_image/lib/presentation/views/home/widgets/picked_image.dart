import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:compress_image/presentation/providers/home_provider.dart';

class PickedImage extends StatelessWidget {

  const PickedImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final image = context.select<HomeProvider, File?>((provider) => provider.image);
    if (image == null) {
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        image,
        fit: BoxFit.cover,
        height: 300,
        width: 300,
      ),
    );
  }

}

