import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal, {super.key});

  final String? label;
  final double? spendingAmount;
  final double spendingPercentageOfTotal;


  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${spendingAmount!.toStringAsFixed(0)}'),
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
            child: Stack(
              children: [
                Container(
                  decoration:  BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(220, 220, 220, 1),
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
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label!),
            ),
          )
        ],
      );
    });
  }
}
