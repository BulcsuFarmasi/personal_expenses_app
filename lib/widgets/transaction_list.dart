import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';
import './no_transactions.dart';

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
