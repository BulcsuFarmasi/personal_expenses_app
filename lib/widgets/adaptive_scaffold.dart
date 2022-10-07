import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/adaptive_app_bar.dart';
import 'package:personal_expenses_app/widgets/home_page_body.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold(
      {super.key,
      required this.addNewTransaction,
      required this.deleteTransaction,
      required this.transactions,
      required this.recentTransactions});

  final VoidCallback addNewTransaction;
  final DeleteTransaction deleteTransaction;
  final List<Transaction> transactions;
  final List<Transaction> recentTransactions;

  @override
  Widget build(BuildContext context) {
    const String title = 'Personal Expenses';
    final PreferredSizeWidget appBar =
        AdaptiveAppBar(title: title, addNewTransaction: addNewTransaction);

    final Widget pageBody = HomePageBody(
        deleteTransaction: deleteTransaction,
        transactions: transactions,
        appBar: appBar,
        recentTransactions: recentTransactions);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget?,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: addNewTransaction,
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
