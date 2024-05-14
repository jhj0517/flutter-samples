import 'package:flutter/material.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    super.key,
    required this.onPressed
  });

  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text('Pick Image'),
    );
  }

}