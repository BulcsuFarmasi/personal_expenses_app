import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
        ),
        Container(
          height: 60,
          width: 10,
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(label)
      ],
    );
  }
}
