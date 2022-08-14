import 'package:basic_tuts/udemy/personal_exxpenses_app/models/transaction.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/pages/home/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import '../../../../extensions/date.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<ChartBarData> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (var element in recentTransactions) {
        if (element.date.isEqual(weekDay)) {
          amount += element.amount;
        }
      }
      return ChartBarData(day: weekDay.toE(), amount: amount);
    }).reversed.toList();
  }

  double get _maxSpending {
    return _groupedTransactionValues.fold<double>(0, (previousValue, element) {
      return previousValue + element.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        label: e.day,
                        spendingAmount: e.amount,
                        spendingPctOfTotal:
                            _maxSpending > 0 ? e.amount / _maxSpending : 0),
                  ))
              .toList(),
        ),
      ),
      elevation: 6,
    );
  }
}
