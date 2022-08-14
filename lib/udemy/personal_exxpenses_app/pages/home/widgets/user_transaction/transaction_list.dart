import 'package:basic_tuts/udemy/personal_exxpenses_app/extensions/date.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/extensions/number.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String transactionId) deleteHandler;

  const TransactionItem(
      {Key? key, required this.transaction, required this.deleteHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text(transaction.amount.toAmount())),
          ),
        ),
        trailing: IconButton(
            onPressed: () {
              deleteHandler(transaction.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
        title: Text(transaction.title),
        subtitle: Text(transaction.date.toFull()),
      ),
      // child: Row(
      //   children: [
      //     Container(
      //       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //       decoration: BoxDecoration(
      //           border: Border.all(
      //               color: Theme.of(context).primaryColor, width: 2)),
      //       padding: const EdgeInsets.all(10),
      //       child: Text(
      //         transaction.amount.toAmount(),
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20,
      //             color: Theme.of(context).primaryColor),
      //       ),
      //     ),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           transaction.title,
      //           style:
      //               const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           transaction.date.toFull(),
      //           style: const TextStyle(color: Colors.grey),
      //         )
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'No transactions added yet!',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/waiting.png',
          fit: BoxFit.cover,
          height: 200,
        )
      ],
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String transactionId) deleteHandler;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 300,
      child: transactions.isEmpty
          ? const EmptyTransaction()
          : ListView.builder(
              itemBuilder: (_, index) {
                return TransactionItem(
                  transaction: transactions[index],
                  deleteHandler: deleteHandler,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
