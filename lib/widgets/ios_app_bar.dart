import 'package:flutter/cupertino.dart';

class IosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IosAppBar(
      {super.key, required this.title, required this.addNewTransaction});

  final String title;
  final VoidCallback addNewTransaction;

  PreferredSizeWidget get appBar => CupertinoNavigationBar(
        middle: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: addNewTransaction,
              child: const Icon(CupertinoIcons.add),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
