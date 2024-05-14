import 'package:flutter/material.dart';


class HomeProvider extends ChangeNotifier {

  HomeProvider({
    required this.exifRepository,
    required this.chunkRepository
  });

  final exifRepository;
  final chunkRepository;

}