import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {

  const NoTransactions();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          return Column(
            children: [
              Text(
                'No transaction added yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              // TODO
              // unite with either of its siblings
              const SizedBox(
                height: 20,
              ),
              Container(
                height: constrains.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        });
  }
}