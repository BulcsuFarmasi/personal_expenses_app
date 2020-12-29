import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      ammout: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      ammout: 16.53,
      date: DateTime.now(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              )),
          Column(
              children: transactions
                  .map((transaction) => Card(
                        child: Row(
                          children: [
                            Container(child: Text(transaction.ammout.toString())),
                            Column(
                              children: [Text(transaction.title), Text(transaction.date.toString())],
                            )
                          ],
                        ),
                      ))
                  .toList()),
        ],
      ),
    ));
  }
}
