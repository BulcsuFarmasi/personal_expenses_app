import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/ios_app_bar.dart';
import 'package:personal_expenses_app/widgets/material_app_bar.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveAppBar(
      {required this.title, required this.addNewTransaction, super.key});

  final String title;
  final VoidCallback addNewTransaction;

  PreferredSizeWidget get appBar => Platform.isIOS
      ? IosAppBar(title: title, addNewTransaction: addNewTransaction)
          as PreferredSizeWidget
      : MaterialAppBar(
          title: title,
          addNewTransaction: addNewTransaction,
        ) as PreferredSizeWidget;

  @override
  Widget build(BuildContext context) {
    return appBar;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => appBar.preferredSize;
}
