import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:basic_tuts/youtube/common_widget/app_layout.dart';
import 'package:basic_tuts/youtube/common_widget/text_field.dart';
import 'package:basic_tuts/youtube/custom_framework/state_binding_observer.dart';
import 'package:flutter/material.dart';

class Chap13 extends StatefulWidget {
  const Chap13({Key? key}) : super(key: key);

  @override
  StateWithBindingObserver<Chap13> createState() => _Chap13State();
}

class _Chap13State extends StateWithBindingObserver<Chap13> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _mainFocus = FocusNode();

  // States
  List<Transaction> transactions = [];

  // Methods
  void _insertTransaction() {
    var transaction = Transaction(
        content: _contentController.text,
        amount: double.tryParse(_amountController.text) ?? 0);
    if (transaction.content.isEmpty) {
      return;
    }
    setState(() {
      transactions.add(transaction);
    });

    // Clear text fields
    _contentController.clear();
    _amountController.clear();
    _mainFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
        textTitle: "Chapter 13, 14 & 15",
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Chapter 13, 14 & 15 - List View',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration:
                          const OutlinedDecoration(textLabel: 'Content'),
                      controller: _contentController,
                      focusNode: _mainFocus,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      onChanged: (text) {
                        // setState(() {
                        //   _content = text;
                        // });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: const OutlinedDecoration(textLabel: 'Amount'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonTheme(
                        child: ElevatedButton(
                      onPressed: () {
                        _insertTransaction();
                      },
                      child: const Text('Insert Transaction'),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'List transaction',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TransactionList(transactions: transactions)
                  ],
                )),
          );
        }),
        floatActionCallback: _insertTransaction);
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
    _amountController.dispose();
    _mainFocus.dispose();
  }
}
