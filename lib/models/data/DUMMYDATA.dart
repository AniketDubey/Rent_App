import 'package:flutter/material.dart';

import 'package:rentapp/models/skeleton/basic_summary.dart';
import 'package:rentapp/models/skeleton/transaction_summary.dart';

class BSummary with ChangeNotifier {
  List<BasicSummary> _items = [
    BasicSummary(
      id: "r1",
      name: "Vijay Shankar",
      remamount: 10000,
      trandetails: [
        /* Transaction(date: DateTime.parse("2020-04-02"), paid_amount: 200),
        Transaction(date: DateTime.parse("2020-07-06"), paid_amount: 2000),
        Transaction(date: DateTime.parse("2019-04-02"), paid_amount: 1200), */
      ],
    ),
    BasicSummary(
      id: "r2",
      name: "Lala",
      remamount: 10000,
      trandetails: [
        /* Transaction(date: DateTime.parse("2022-04-02"), paid_amount: 200),
        Transaction(date: DateTime.parse("2018-07-06"), paid_amount: 2000),
        Transaction(date: DateTime.parse("2016-04-02"), paid_amount: 1200), */
      ],
    ),
  ];

  List<BasicSummary> get items {
    return [..._items];
  }

  BasicSummary findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  /* Map<String, int> aniket = {
    "r1": 2000,
    "r2": 3000,
  };

  Map<String, int> get amit {
    return aniket;
  } */

  void add_Trans(String id, double amount, DateTime pickdate) {
    final BasicSummary _userprofile =
        items.firstWhere((element) => element.id == id);

    // _userprofile.remamount = _userprofile.remamount - amount;
    //print(_userprofile.remamount);
    double updatedamount = 0;
    if (_userprofile.trandetails.length == 0) {
      updatedamount = _userprofile.remamount - amount;
    } else {
      updatedamount = _userprofile.trandetails[0].aboutreq - amount;
    }
    _userprofile.trandetails.add(Transaction(
      date: pickdate,
      paid_amount: amount,
      aboutreq: updatedamount,
    ));
    //amit[id] = amit[id]! - amount.toInt();
    notifyListeners();
  }

  void del_Trans(String id, DateTime date) {
    final BasicSummary _userprofile =
        items.firstWhere((element) => element.id == id);
    final expecIndex =
        _userprofile.trandetails.indexWhere((element) => element.date == date);
    _userprofile.trandetails.removeAt(expecIndex);
    notifyListeners();
  }
}
