import 'package:flutter/material.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/extensions/number.dart';
import 'package:basic_tuts/udemy/personal_exxpenses_app/extensions/date.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double amount, [DateTime? date]) addHandler;
  const TransactionForm({Key? key, required this.addHandler}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleEdittingController =
      TextEditingController();
  final TextEditingController _amountEdittingController =
      TextEditingController();
  DateTime? chosenDate;

  @override
  void dispose() {
    super.dispose();
    _titleEdittingController.dispose();
    _amountEdittingController.dispose();
  }

  void _addHandler() {
    var title = _titleEdittingController.text;
    var amount = _amountEdittingController.text.toDouble();
    if (title.isNotEmpty && amount > 0) {
      widget.addHandler(title, amount.toDouble(), chosenDate);
      FocusScope.of(context).requestFocus(FocusNode());
      _resetForm();
    }
  }

  void _resetForm() {
    _titleEdittingController.clear();
    _amountEdittingController.clear();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(DateTime.now().year + 5))
        .then((value) {
      if (value != null) {
        setState(() {
          chosenDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Center(
                child: Text(
              'Transaction form',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            )),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _titleEdittingController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Title'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
                controller: _amountEdittingController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Amount')),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(chosenDate != null
                    ? chosenDate!.toFull()
                    : 'No date chosen!'),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text('Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            ElevatedButton(
                child: const Text('Add Transaction'),
                onPressed: () {
                  _addHandler();
                })
          ])),
    );
  }
}
