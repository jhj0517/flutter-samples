import 'package:flutter/material.dart';

class MetaDataInput extends StatefulWidget {
  final void Function(String) onComplete;

  const MetaDataInput({
    super.key,
    required this.onComplete,
  });

  @override
  MetaDataInputState createState() => MetaDataInputState();
}

class MetaDataInputState extends State<MetaDataInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter metadata',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                widget.onComplete(_controller.text);
              },
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}