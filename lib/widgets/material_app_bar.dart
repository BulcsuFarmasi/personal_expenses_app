import 'package:flutter/material.dart';

class MaterialAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MaterialAppBar(
      {super.key, required this.title, required this.addNewTransaction});

  final String title;
  final VoidCallback addNewTransaction;

  PreferredSizeWidget get appBar =>
      AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addNewTransaction,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => appBar.preferredSize;
}
