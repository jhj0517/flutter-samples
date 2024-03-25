import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/g_drive_provider.dart';
import '../utils/text_file_manager.dart' as util;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late GDriveProvider gDriveProvider;
  late TextEditingController controller;

  @override
  void initState() {
    gDriveProvider = context.read<GDriveProvider>();
    controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.text = await util.readTextFile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Google Drive Backup"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              onChanged: (text) {
                gDriveProvider.setText(text);
              },
              decoration: InputDecoration(
                hintText: "Data to save",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              child: _buildUI("Backup", Icons.backup),
              onTap: () async {
                await gDriveProvider.upload();
              },
            ),
            InkWell(
              child: _buildUI("Load", Icons.download),
              onTap: () async {
                await gDriveProvider.download();
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUI(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0), // Adds padding around the row for a "fatter" appearance
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(
            icon,
            size: 30, // Increase the icon size
          ),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20, // Increase the font size
              fontWeight: FontWeight.bold, // Make the text bold for more impact
            ),
          ),
        ],
      ),
    );
  }
}
