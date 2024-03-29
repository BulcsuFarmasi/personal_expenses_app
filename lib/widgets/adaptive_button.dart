import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  const AdaptiveFlatButton({super.key, this.onPressed, this.text});

  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    print('build() AdaptiveButton');
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
            child: Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
