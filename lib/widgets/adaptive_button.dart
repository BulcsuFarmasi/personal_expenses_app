import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton({this.onPressed, this.text});

  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    print('build() AdaptiveButton');
    final ThemeData theme = Theme.of(context);
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              text!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(
              text!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(foregroundColor: theme.primaryColor),
          );
  }
}
