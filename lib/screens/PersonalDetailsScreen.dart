import 'package:flutter/material.dart';

import 'package:rentapp/models/data/DUMMYDATA.dart';
import 'package:rentapp/models/skeleton/basic_summary.dart';
import 'package:rentapp/models/skeleton/transaction_summary.dart';

import 'package:provider/provider.dart';

class PersonalDetailsScreen extends StatelessWidget {
  final String id;
  PersonalDetailsScreen(this.id);

  @override
  Widget build(BuildContext context) {
    /* final BasicSummary _customer =
        DUMMYDATA.firstWhere((element) => element.id == id); 


    final List<Transaction> _history = _customer.trandetails;*/

    final BasicSummary _customer = Provider.of<BSummary>(
      context,
      listen: false,
    ).findByID(id);
    final List<Transaction> _history = _customer.trandetails;
    _history.sort((a, b) {
      return -a.date.compareTo(b.date);
    });

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ),
        ],
        title: Text("${_customer.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final String _date =
                _history[index].date.toString().substring(0, 10);

            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${_date}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Text(
                      "Rs. ${_history[index].paid_amount.toInt()}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                    Spacer(),
                    Text(
                      "${_customer.remamount.toInt()}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _history.length,
        ),
      ),
    );
  }
}
