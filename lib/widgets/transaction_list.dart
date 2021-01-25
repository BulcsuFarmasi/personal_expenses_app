import 'package:flutter/material.dart';



import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTransaction);
  final List<Transaction> transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return transactions.isEmpty
        ? LayoutBuilder(builder: (BuildContext context, BoxConstraints constrains) {
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
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                transaction: transactions[index],
                deleteTransaction: deleteTransaction,
              );
            },
            itemCount: transactions.length,
          );
  }
}
