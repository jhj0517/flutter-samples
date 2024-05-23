import 'package:flutter/material.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    super.key,
    required this.onPressed
  });

  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      child: const Text(
        'Pick Image',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

}