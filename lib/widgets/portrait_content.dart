import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

class PortaitContent extends StatelessWidget {
  const PortaitContent(
      {super.key,
      required this.transactionListWidget,
      required this.appBar,
      required this.recentTransactions});

  final Widget transactionListWidget;
  final PreferredSizeWidget appBar;
  final List<Transaction> recentTransactions;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(recentTransactions),
        ),
        transactionListWidget,
      ],
    );
  }
}
