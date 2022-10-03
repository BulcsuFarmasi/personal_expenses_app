import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/no_transactions.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});

  final List<Transaction> transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    transactions.sort((Transaction aTransaction, Transaction bTransaction) {
      return bTransaction.date.compareTo(aTransaction.date);
    });
    return transactions.isEmpty
        ? const NoTransactions()
        : ListView(
            children: transactions.map((Transaction transaction) {
            return TransactionItem(
              key: ValueKey(transaction.id),
              transaction: transaction,
              deleteTransaction: deleteTransaction,
            );
          }).toList());
  }
}
