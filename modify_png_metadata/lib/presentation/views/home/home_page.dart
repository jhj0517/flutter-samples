import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/providers.dart';
import '../widgets/common/common.dart';
import 'widgets/memo_tile.dart';
import 'widgets/memo_input_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ThemeProvider themeProvider;
  late HomeProvider homeProvider;

  @override
  void initState() {
    themeProvider = context.read<ThemeProvider>();
    homeProvider = context.read<HomeProvider>();
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> init() async{
    homeProvider.readMemos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: NormalAppBar(title: Intl.message("appTitle")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

        ],
      )
    );
  }
}
