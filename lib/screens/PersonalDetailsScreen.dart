import 'package:flutter/material.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';

import 'package:rentapp/models/skeleton/transaction_summary.dart';
import 'package:rentapp/models/data/DUMDATA.dart';

import 'package:provider/provider.dart';
import 'package:rentapp/screens/Add_Transaction_Screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final String id;
  PersonalDetailsScreen(this.id);

  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Base_Summary _customer = Provider.of<BSummary>(context).findByID(widget.id);

    final List<Transaction> _history = _customer.trandetails;
    _history.sort((a, b) {
      return -a.date.compareTo(b.date);
    });

    void _submitData(double amount, DateTime pickedDate) {
      if (_history.length != 0) {
        if (_history[0].date.isAfter(pickedDate) ||
            _history[0].date == pickedDate) return;
      }

      setState(() {
        Provider.of<BSummary>(context, listen: false).add_Trans(
          widget.id,
          amount,
          pickedDate,
        );
      });
    }

    void _deleteTran(String id, String tid) {
      Provider.of<BSummary>(context, listen: false).del_Trans(
        id,
        tid,
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Add_Transaction(_submitData);
                  },
                );
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
        title: Text(
          "${_customer.name}'s Transactions",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final String _date =
                _history[index].date.toString().substring(0, 10);

            return Dismissible(
              key: ValueKey(_history[index]),
              background: Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteTran(widget.id, _history[index].Tid);
              },
              child: Card(
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
                      Text(
                        "Rs. ${_history[index].aboutreq.toInt()}",
                        //"${_showamount[widget.id]!.toInt()}",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
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
