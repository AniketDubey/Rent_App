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

  void _presentDatePicker() async {
    await showDatePicker(
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

  bool _onMe = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 25),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? "Select Date"
                      : DateFormat.yMd().format(_selectedDate!),
                ),
                Spacer(),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                ),
                Spacer(),
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
                      widget._submitData(_paidamount, _selectedDate, _onMe);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            title: Text("Amount I gave"),
            value: _onMe,
            onChanged: (newvalue) {
              setState(
                () {
                  _onMe = !_onMe;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
