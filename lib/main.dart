import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // String titleInput;
  // String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Personal Expenses'),
            ),
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.blue,
                      child: Text('CHART!'),
                      elevation: 5,
                    )),
                Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Title'),
                          controller: titleController,
                          // onChanged: (String value) {
                          //   titleInput = value;
                          // },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Amount'),
                          controller: amountController,
                          // onChanged: (String value) {
                          //   amountInput = value;
                          // },
                        ),
                        FlatButton(
                          child: Text('Add Transaction'),
                          textColor: Colors.purple,
                          onPressed: () {
                            print(titleController.text);
                            print(amountController.text);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: transactions
                      .map(
                        (transaction) => Card(
                            child: Row(children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.purple, width: 2),
                              ),
                              child: Text(
                                '\$${transaction.ammout}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(transaction.date),
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          )
                        ])),
                      )
                      .toList(),
                )
              ],
            )));
  }
}
