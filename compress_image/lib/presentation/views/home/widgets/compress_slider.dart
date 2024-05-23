import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:compress_image/presentation/providers/home_provider.dart';

class CompressSlider extends StatelessWidget {

  const CompressSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final imageQuality = context.select<HomeProvider, double>((provider) => provider.imageQuality);

    return Column(
      children: [
        Text("Image Quality : ${imageQuality.toInt()}"),
        Slider(
          value: imageQuality,
          min: 0,
          max: 100,
          divisions: 100,
          label: "Quality : ${imageQuality.round().toString()}",
          onChanged: (value) {
            final homeProvider= Provider.of<HomeProvider>(context, listen:false);
            homeProvider.setImageQuality(value);
          },
        )
      ],
    );
  }
}