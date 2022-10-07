import 'package:flutter/cupertino.dart';

class IosAppBar extends StatelessWidget {
  const IosAppBar({super.key, required this.title, required this.addNewTransaction});
  final String title;
  final VoidCallback addNewTransaction;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
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
  }
}
