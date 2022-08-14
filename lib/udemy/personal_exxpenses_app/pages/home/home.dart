import 'package:basic_tuts/udemy/personal_exxpenses_app/models/transaction.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/pages/home/widgets/chart/chart.dart';
import './widgets/user_transaction/transaction_form.dart';
import './widgets/user_transaction/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [
    // Transaction(
    //     id: '1', title: 'Transaction 01', amount: 10.99, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Transaction 02', amount: 20.01, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return transactions
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(String title, double amount, [DateTime? date]) {
    var newTransaction = Transaction(
        id: generateRandomString(3),
        amount: amount,
        title: title,
        date: date ?? DateTime.now());
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TransactionForm(addHandler: ((title, amount, [date]) {
              _addTransaction(title, amount, date);
              Navigator.pop(_);
            })));
  }

  void _deleteTransaction(String transactionId) {
    setState(() {
      transactions.removeWhere((element) => element.id == transactionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              recentTransactions: _recentTransactions,
            ),
            TransactionList(
                transactions: transactions, deleteHandler: _deleteTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionForm(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
