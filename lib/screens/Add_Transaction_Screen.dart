import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Add_Transaction extends StatefulWidget {
  final Function _submitData;
  Add_Transaction(this._submitData);

  @override
  _Add_TransactionState createState() => _Add_TransactionState();
}

class _Add_TransactionState extends State<Add_Transaction> {
  DateTime? _selectedDate;

  final _amountController = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? "Select Date"
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    Container(
                      width: 130,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                        ),
                        controller: _amountController,
                        onSubmitted: (amount) {
                          final _paidamount = double.parse(amount);
                          widget._submitData(_paidamount, _selectedDate);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
