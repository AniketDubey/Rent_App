import 'package:flutter/material.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';
import 'package:rentapp/models/skeleton/transaction_summary.dart';

class BSummary with ChangeNotifier {
  Map<String, Object> _items = {
    "11": Base_Summary(
      name: "Vijay Bhai",
      remamount: 10000,
      trandetails: [],
    ),
    "12": Base_Summary(
      name: "Srivastava",
      remamount: 1000,
      trandetails: [],
    ),
  };

  Map<String, Object> get items {
    return _items;
  }

  Base_Summary findByID(String ID) {
    return _items[ID] as Base_Summary;
  }

  void add_Trans(String id, double amount, DateTime pickdate) {
    Base_Summary _userprofile = items[id] as Base_Summary;

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
    _userprofile.remamount = updatedamount;
    //amit[id] = amit[id]! - amount.toInt();
    notifyListeners();
  }

  void del_Trans(String id, DateTime date) {
    Base_Summary _userprofile = items[id] as Base_Summary;
    final expecIndex =
        _userprofile.trandetails.indexWhere((element) => element.date == date);
    _userprofile.trandetails.removeAt(expecIndex);
    notifyListeners();
  }

  void Add_NewMember(Map<String, Object> _enteredDetails) {
    if (_items.containsKey(_enteredDetails["Aadhar"])) return;

    List<Transaction> _emptyTran = [];
    _items.putIfAbsent(
        _enteredDetails["Aadhar"].toString(),
        () => Base_Summary(
              name: _enteredDetails["Name"].toString(),
              remamount: _enteredDetails["ReqAmount"] as double,
              trandetails: _emptyTran,
            ));
    notifyListeners();
  }
}
