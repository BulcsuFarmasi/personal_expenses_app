import 'package:flutter/material.dart';

class MaterialAppBar extends StatelessWidget {
  const MaterialAppBar({super.key, required this.title, required this.addNewTransaction});

  final String title;
  final VoidCallback addNewTransaction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: addNewTransaction,
        ),
      ],
    );
  }
}
