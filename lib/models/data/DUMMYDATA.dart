import 'package:flutter/material.dart';

import 'package:rentapp/models/skeleton/basic_summary.dart';
import 'package:rentapp/models/skeleton/transaction_summary.dart';

class BSummary with ChangeNotifier {
  List<BasicSummary> _items = [
    BasicSummary(
      id: "r1",
      name: "Vijay Shankar",
      remamount: 0,
      trandetails: [
        Transaction(date: DateTime.parse("2020-04-02"), paid_amount: 200),
        Transaction(date: DateTime.parse("2020-07-06"), paid_amount: 2000),
        Transaction(date: DateTime.parse("2019-04-02"), paid_amount: 1200),
      ],
    ),
    BasicSummary(
      id: "r2",
      name: "Lala",
      remamount: 0,
      trandetails: [
        Transaction(date: DateTime.parse("2022-04-02"), paid_amount: 200),
        Transaction(date: DateTime.parse("2018-07-06"), paid_amount: 2000),
        Transaction(date: DateTime.parse("2016-04-02"), paid_amount: 1200),
      ],
    ),
  ];

  List<BasicSummary> get items {
    return [..._items];
  }

  BasicSummary findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
