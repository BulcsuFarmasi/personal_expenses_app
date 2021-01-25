import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    @required this.transaction,
    @required this.deleteTransaction,
  });

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.ammout.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
        ),
        trailing: (mediaQuery.size.width > 460)
            ? FlatButton.icon(
            icon: const Icon(Icons.delete),
            textColor: Theme.of(context).errorColor,
            onPressed: () => deleteTransaction(transaction.id),
            label: const Text('Delete Transaction'))
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}