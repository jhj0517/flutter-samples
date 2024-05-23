import 'package:compress_image/presentation/views/home/widgets/compress_slider.dart';
import 'package:compress_image/presentation/views/home/widgets/image_capacity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../widgets/common/common.dart';
import 'widgets/picked_image.dart';
import 'widgets/custom_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final success = await homeProvider.pickImage();
    if (!success){
      _showSnackBar("Failed to pick image");
    }
  }

  Future<void> _compressImage() async{
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final success = await homeProvider.compressImage();

    if (success){
      _showSnackBar("New compressed image has been saved in the Gallery.");
    } else {
      _showSnackBar("No image is selected");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(title: "Compress Image"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            const PickedImage(),
            const SizedBox(height: 20),
            CustomButton(text: "Pick Image", onPressed: _pickImage),
            const SizedBox(height: 20),
            const ImageCapacity(),
            const SizedBox(height: 20),
            const CompressSlider(),
            const SizedBox(height: 20),
            CustomButton(text: "Compress", onPressed: _compressImage, color: Colors.amber)
          ],
        )
      )
    );
  }
}
