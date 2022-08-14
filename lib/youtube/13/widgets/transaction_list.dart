import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  // Methods
  // List<Widget> _buildTransactionListWithLoadAll() {
  //   return transactions.asMap().entries.map((entry) {
  //     var index = entry.key;
  //     var transaction = entry.value;
  //     return Card(
  //       color: index % 2 == 0 ? Colors.green[100] : Colors.yellow[100],
  //       child: ListTile(
  //         onTap: () {
  //           print("Content is: ${transaction.content}");
  //         },
  //         leading: const FlutterLogo(size: 72.0),
  //         title: Text(transaction.content.isNotEmpty
  //             ? transaction.content
  //             : "No content"),
  //         subtitle: Text(transaction.amount.toString()),
  //       ),
  //     );
  //   }).toList();
  // }

  Widget _buildTransactionListWithScrollToLoad() {
    if (transactions.isEmpty) {
      return const Center(
        child: Text('List is empty'),
      );
    }
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var transaction = transactions[index];
          return _buildBasicCard(index, transaction);
        });
  }

  Widget _buildBasicCard(int index, Transaction transaction) {
    return Card(
        color: index % 2 == 0 ? Colors.green[100] : Colors.yellow[100],
        child: ListTile(
          onTap: () {},
          leading: const FlutterLogo(size: 72.0),
          title: Text(transaction.content.isNotEmpty
              ? transaction.content
              : "No content"),
          subtitle: Text(transaction.amount.toString()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // ListView(children: <Widget>[]) -> Load all children at the same time
    // ListView(itemBuilder: ...) -> Vuốt tới đâu, load tới đấy
    return SizedBox(
        height: 500,
        child:
            // ListView(
            //   children: _buildTransactionListWithLoadAll(),
            // ),
            _buildTransactionListWithScrollToLoad());
  }
}
