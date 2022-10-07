import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

class LandscapeContent extends StatefulWidget {
  const LandscapeContent(
      {super.key,
      required this.transactionListWidget,
      required this.appBar,
      required this.recentTransactions});

  final Widget transactionListWidget;
  final PreferredSizeWidget appBar;
  final List<Transaction> recentTransactions;

  @override
  State<LandscapeContent> createState() => _LandscapeContentState();
}

class _LandscapeContentState extends State<LandscapeContent> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show Chart',
              style: theme.textTheme.headline6,
            ),
            Switch.adaptive(
                activeColor: theme.colorScheme.secondary,
                value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                }),
          ],
        ),
        if (_showChart)
          SizedBox(
            height: (mediaQuery.size.height -
                    widget.appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.7,
            child: Chart(widget.recentTransactions),
          ),
        widget.transactionListWidget
      ],
    );
  }
}
