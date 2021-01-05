import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupedTranactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.00;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].ammout;
        }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0, 1), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTranactionValues.fold(0.0, (sum, transactionValue) {
      return sum += transactionValue['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTranactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTranactionValues.map((transactionValue) {
          return ChartBar(
            transactionValue['day'],
            transactionValue['amount'],
            totalSpending == 0.0 ? 0.0 : (transactionValue['amount'] as double) / totalSpending,
          );
        }).toList(),
      ),
    );
  }
}
