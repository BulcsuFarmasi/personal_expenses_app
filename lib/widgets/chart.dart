import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/daily_spending.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransactions, {super.key}) {
    print('Constructor() Chart');
  }

  final List<Transaction> recentTransactions;

  List<DailySpending> get groupedTransactionValues {
    Map<DateTime, DailySpending> dailySpendingsByDay = {};

    const earlyestFareTimeDifference = 7;

    for (int i = earlyestFareTimeDifference - 1; i >= 0; i--) {
      final weekDay = DateTime.now().subtract(Duration(days: i));
      final weekDayMidnight = DateTime(weekDay.year, weekDay.month,weekDay.day);
      dailySpendingsByDay[weekDayMidnight] =
          DailySpending(DateFormat.E().format(weekDay).substring(0, 1), 0);
    }

    for (Transaction recentTransaction in recentTransactions) {
      final transactionDate = DateTime(
          recentTransaction.date.year, recentTransaction.date.month,
          recentTransaction.date.day);
      dailySpendingsByDay[transactionDate]!.amount = recentTransaction.amount;
    }

    return dailySpendingsByDay.values.toList();
  }


  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (double sum, DailySpending transactionValue) {
      return sum += transactionValue.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() Chart');
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((transactionValue) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                transactionValue.dayAbbrivation,
                transactionValue.amount,
                totalSpending == 0.0 ? 0.0 : transactionValue
                    .amount / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
