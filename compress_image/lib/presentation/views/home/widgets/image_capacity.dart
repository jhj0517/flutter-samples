import 'package:flutter/material.dart';

import 'package:compress_image/presentation/providers/providers.dart';
import 'package:provider/provider.dart';

class ImageCapacity extends StatelessWidget {
  const ImageCapacity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = context.select<HomeProvider, int?>((provider) => provider.imageSize);

    String displaySize;
    switch(imageSize){
      case null:
        displaySize = "No image is selected";
      case >= 1024 && < 1024*1024:
        displaySize = "Size: ${(imageSize / (1024)).toStringAsFixed(2)} KB";
      case >= 1024*1024:
        displaySize = "Size: ${(imageSize / (1024 * 1024)).toStringAsFixed(2)} MB";
      default:
       displaySize = "No image is selected";
    }

    return Text(
      style: const TextStyle(color: Colors.grey, fontSize: 20),
      displaySize
    );
  }

}