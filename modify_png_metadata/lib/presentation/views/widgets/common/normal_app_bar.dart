import 'package:flutter/material.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NormalAppBar({
    required this.title,
    this.elevation = 4.0,
    this.enableBackButton = false,
    super.key
  });

  final String title;
  final double elevation;
  final bool enableBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      elevation: elevation,
      leading: enableBackButton
        ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        )
        : null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}