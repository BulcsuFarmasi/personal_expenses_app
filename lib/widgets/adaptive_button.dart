import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  AdaptiveFlatButton({this.onPressed, this.text});
  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    print('build() AdaptiveButton');
    final ThemeData theme = Theme.of(context);
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: theme.primaryColor,
          );
  }
}
