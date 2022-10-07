import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/landscape_content.dart';
import 'package:personal_expenses_app/widgets/portrait_content.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';
import 'package:personal_expenses_app/widgets/transaction_list_container.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.deleteTransaction, required this.transactions, required this.appBar, required this.recentTransactions});

  final DeleteTransaction deleteTransaction;
  final List<Transaction> transactions;
  final List<Transaction> recentTransactions;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final Widget transactionListWidget = TransactionListContainer(
        deleteTransaction: deleteTransaction,
        transactions: transactions,
        appBar: appBar);
    return  SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              LandscapeContent(
                  transactionListWidget: transactionListWidget,
                  appBar: appBar,
                  recentTransactions: recentTransactions),
            if (!isLandscape)
              PortaitContent(
                transactionListWidget: transactionListWidget,
                appBar: appBar,
                recentTransactions: recentTransactions,
              )
          ],
        ),
      ),
    );
  }
}
