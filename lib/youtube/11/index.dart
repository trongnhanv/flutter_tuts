import './models/transaction.dart';
import 'package:basic_tuts/youtube/common_widget/app_layout.dart';
import 'package:basic_tuts/youtube/common_widget/text_field.dart';
import 'package:basic_tuts/youtube/custom_framework/state_binding_observer.dart';
import 'package:flutter/material.dart';

class Chap11 extends StatefulWidget {
  const Chap11({Key? key}) : super(key: key);

  @override
  StateWithBindingObserver<Chap11> createState() => _Chap11State();
}

class _Chap11State extends StateWithBindingObserver<Chap11> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _mainFocus = FocusNode();

  // Vars
  bool _isSnackbarActive = false;

  // States
  List<Transaction> transactions = [];

  // Methods
  List<Widget> _buildTransactionList() {
    return transactions.asMap().entries.map((entry) {
      var index = entry.key;
      var transaction = entry.value;
      return Card(
        color: index % 2 == 0 ? Colors.green[100] : Colors.yellow[100],
        child: ListTile(
          onTap: () {},
          leading: const FlutterLogo(size: 72.0),
          title: Text(transaction.content.isNotEmpty
              ? transaction.content
              : "No content"),
          subtitle: Text(transaction.amount.toString()),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(child: Builder(builder: (context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Chapter 11 & 12 - Show data in Card & ListTile',
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
                decoration: const OutlinedDecoration(textLabel: 'Content'),
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
                onChanged: (text) {
                  // setState(() {
                  //   _amount = text;
                  // });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonTheme(
                  child: ElevatedButton(
                onPressed: () {
                  if (_isSnackbarActive) {
                    return;
                  }
                  _isSnackbarActive = true;
                  var transaction = Transaction(
                      content: _contentController.text,
                      amount: double.tryParse(_amountController.text) ?? 0);
                  if (transaction.content.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[200],
                            content: const Text("Error!"),
                          ),
                        )
                        .closed
                        .then((value) {
                      _isSnackbarActive = false;
                    });
                    return;
                  }
                  setState(() {
                    transactions.add(transaction);
                  });

                  // Clear text fields
                  _contentController.clear();
                  _amountController.clear();
                  _mainFocus.requestFocus();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        const SnackBar(
                          content: Text("Successfully!"),
                        ),
                      )
                      .closed
                      .then((value) {
                    _isSnackbarActive = false;
                  });
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTransactionList(),
              )
            ],
          ));
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
    _amountController.dispose();
    _mainFocus.dispose();
  }
}
