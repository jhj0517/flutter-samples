import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modify_png_metadata/repositories/chunk_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../di/dependency_injection.dart';
import '../../providers/providers.dart';
import '../widgets/common/common.dart';
import 'widgets/picked_image.dart';
import 'widgets/pick_image_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late HomeProvider homeProvider;
  File? _image;

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
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(title: "Modify PNG Metadata Sample"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PickedImage(image: _image),
          ],
        )
      )
    );
  }
}
