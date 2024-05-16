import 'package:flutter/material.dart';
import 'package:modify_png_metadata/presentation/views/home/widgets/meta_data_output.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../widgets/common/common.dart';
import 'widgets/picked_image.dart';
import 'widgets/pick_image_button.dart';
import 'widgets/meta_data_input.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum PossibleMimes{
  png
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
      _showSnackBar("The file is not PNG");
    }
  }

  Future<void> _addtEXtMetaData(String text) async {
    if (homeProvider.image == null) {
      _showSnackBar('Select the image first');
      return;
    }

    final success = await homeProvider.saveWithMetaData(text: text);
    _showSnackBar(success ? 'Image has been saved with new metadata' : 'Failed to save image with new metadata');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(title: "Modify PNG Metadata"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            const PickedImage(),
            const SizedBox(height: 20),
            PickImageButton(onPressed: _pickImage),
            const SizedBox(height: 40),
            MetaDataInput(onComplete: (input) => _addtEXtMetaData(input)),
            const SizedBox(height: 10),
            const MetaDataOutput(),
          ],
        )
      )
    );
  }
}
