import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import 'package:compress_image/core/services/image_service.dart';


class HomeProvider extends ChangeNotifier {

  HomeProvider();

  File? _image;
  File? get image => _image;

  int? _imageSize;
  int? get imageSize => _imageSize;

  double _imageQuality=100;
  double get imageQuality => _imageQuality;

  Future<bool> pickImage() async {
    final pickedFile = await ImageService.pickImage();

    if (pickedFile != null) {
      _image = pickedFile;
      _imageSize = image!.lengthSync();
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> compressImage() async{
    if (image==null){
      return false;
    }

    final compressedImage = await ImageService.compressImage(
      imageFile: image!,
      quality: imageQuality.toInt()
    );
    await ImageService.saveToGallery(filePath: compressedImage.path);
    return true;
  }

  void setImageQuality(double value){
    _imageQuality = value;
    notifyListeners();
  }


}