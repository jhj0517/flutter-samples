import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
            _buildProgressBar(),
            _buildStatusText(),
            const SizedBox(height: 30),
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
              child: _buildButtonUI("Backup", Icons.backup),
              onTap: () async {
                await gDriveProvider.upload();
              },
            ),
            InkWell(
              child: _buildButtonUI("Load", Icons.download),
              onTap: () async {
                await gDriveProvider.download();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonUI(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(){
    return Consumer<GDriveProvider>(
      builder: (context, gDriveProvider, child) {
        final GDriveStatus status = gDriveProvider.status;

        if (status == GDriveStatus.initialized ||
            status == GDriveStatus.isOnTask) {
          return const CircularProgressIndicator(
            color: Colors.purple,
          );
        }

        if (status == GDriveStatus.downloadComplete){
          Future.delayed(const Duration(milliseconds: 1000), () {
            Phoenix.rebirth(context);
          });
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStatusText() {
    return Consumer<GDriveProvider>(
      builder: (context, gDriveProvider, child) {
        final GDriveStatus status = gDriveProvider.status;

        return Text(
          "status-${status.name}",
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}
