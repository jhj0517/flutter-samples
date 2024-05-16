import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modify_png_metadata/core/services/image_service.dart';
import 'package:modify_png_metadata/core/services/png_chunk_service.dart';
import 'package:modify_png_metadata/presentation/views/home/widgets/meta_data_output.dart';
import 'package:modify_png_metadata/repositories/chunk_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart';

import '../../../di/dependency_injection.dart';
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
  File? _image;
  List<Map<String, dynamic>>? _chunk;

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The file is not PNG')),
      );
    }
  }

  void _addtEXt(String text){
    _chunk = PngChunkService.addtEXt(
      chunk: _chunk!,
      text: text
    );
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(title: "Modify PNG Metadata Sample"),
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
            MetaDataInput(onComplete: (input) => _addtEXt),
            const SizedBox(height: 10),
            MetaDataOutput(metadata: "${_chunk}"),
          ],
        )
      )
    );
  }
}
