import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

class TransactionListContainer extends StatelessWidget {
  const TransactionListContainer({super.key, required this.deleteTransaction, required this.transactions, required this.appBar});

  final DeleteTransaction deleteTransaction;
  final List<Transaction> transactions;
  final PreferredSizeWidget appBar;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: TransactionList(transactions, deleteTransaction),
    );
  }
}
