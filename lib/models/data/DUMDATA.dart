import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';
import 'package:rentapp/models/skeleton/transaction_summary.dart';
import 'package:http/http.dart' as http;

class BSummary with ChangeNotifier {
  Map<String, Object> _items = {
    /* "11": Base_Summary(
      name: "Vijay Bhai",
      remamount: 10000,
      trandetails: [],
    ),
    "12": Base_Summary(
      name: "Srivastava",
      remamount: 1000,
      trandetails: [],
    ), */
  };

  Map<String, Object> get items {
    return _items;
  }

  Base_Summary findByID(String uniID) {
    return _items[uniID] as Base_Summary;
  }

  Future<void> add_Trans(String id, double amount, DateTime pickdate) async {
    Base_Summary _userprofile = items[id] as Base_Summary;
    //print(id);
    // _userprofile.remamount = _userprofile.remamount - amount;
    //print(_userprofile.remamount);
    double updatedamount = 0;
    if (_userprofile.trandetails.length == 0) {
      updatedamount = _userprofile.remamount - amount;
    } else {
      updatedamount = _userprofile.trandetails[0].aboutreq - amount;
    }

    final url = Uri.parse(
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary/Transaction.json");

    try {
      final res = await http.post(
        url,
        body: jsonEncode(
          {
            "Date": pickdate.toString(),
            "Paid Amount": amount,
            "Remaining": updatedamount,
          },
        ),
      );
      //print(res.statusCode);
    } catch (error) {}

    /* _userprofile.trandetails.add(Transaction(
      date: pickdate,
      paid_amount: amount,
      aboutreq: updatedamount,
    ));
    _userprofile.remamount = updatedamount; */
    //amit[id] = amit[id]! - amount.toInt();
    //notifyListeners();
    _items.clear();
    await fetchUsers();
    //notifyListeners();
  }

  Future<void> Add_NewMember(Map<String, Object> _enteredDetails) async {
    if (_items.containsKey(_enteredDetails["Aadhar"])) return;

    //print(_items.length);
    final url = Uri.parse(
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users.json");

    try {
      final res = await http.post(
        url,
        body: jsonEncode(
          {
            "uniID": "${_enteredDetails["Aadhar"]}",
            "Summary": {
              "Name": _enteredDetails["Name"],
              "ReqAmount": _enteredDetails["ReqAmount"],
              "Transaction": [],
            },
          },
        ),
      );

      /* List<Transaction> _emptyTran = [];
      _items.putIfAbsent(
          _enteredDetails["Aadhar"].toString(),
          () => Base_Summary(
                name: _enteredDetails["Name"].toString(),
                remamount: _enteredDetails["ReqAmount"] as double,
                trandetails: _emptyTran,
              )); */

      //print(_items.length);
      //print(res.body);
    } catch (error) {
      //print(error);
    }
    await fetchUsers();
    //print(_items.length);
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    const url =
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users.json";

    try {
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      //print(_items.length);
      extractedData.forEach((key, value) {
        List<Transaction> _uTrans = [];
        String uniID = value["uniID"];
        //print(uniID);
        if (value["Summary"]["Transaction"] != null) {
          var snippet = value["Summary"]["Transaction"] as Map<String, dynamic>;
          snippet.forEach(
            (key, value) {
              _uTrans.add(
                Transaction(
                  Tid: key,
                  date: DateTime.parse(value["Date"]),
                  paid_amount: value["Paid Amount"],
                  aboutreq: value["Remaining"],
                ),
              );
            },
          );
        }

        _items.putIfAbsent(
            key,
            () => Base_Summary(
                  name: value["Summary"]["Name"].toString(),
                  remamount: value["Summary"]["ReqAmount"] as double,
                  trandetails: _uTrans,
                ));
        /* _items.forEach((key, value) {
          
          _items.u
          Base_Summary checkval = _items[key] as Base_Summary;
          /* print(checkval.name);
          print(checkval.remamount); */
          checkval.trandetails.forEach((element) {
            print(element.Tid);
          });
        }); */
      });
      //print(extractedData);
    } catch (error) {
      //print(error);
    }
    //print(_items.length);
    notifyListeners();
  }

  Future<void> del_Trans(String id, String tid) async {
    //print(date);
    Base_Summary _userprofile = items[id] as Base_Summary;
    final expecIndex =
        _userprofile.trandetails.indexWhere((element) => element.Tid == tid);

    Transaction? savedValue = _userprofile.trandetails[expecIndex];

    final presentAmount = _userprofile.trandetails[expecIndex].paid_amount;

    if (expecIndex != 0) {
      for (var i = 0; i < expecIndex; i++) {
        _userprofile.trandetails[i].aboutreq += presentAmount;
      }
    }

    _userprofile.trandetails.removeAt(expecIndex);
    notifyListeners();

    //print(response.statusCode);
    try {
      var response = await http.delete(Uri.parse(
          "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary/Transaction/$tid.json"));

      /*  print(response);
      print(response.body);
      print(response.statusCode); */
      if (response.statusCode >= 400) {
        if (expecIndex != 0) {
          for (var i = 0; i < expecIndex; i++) {
            _userprofile.trandetails[i].aboutreq -= presentAmount;
          }
        }

        _userprofile.trandetails.insert(expecIndex, savedValue);

        notifyListeners();
      }
      savedValue = null;
    } catch (error) {
      print(error);
    }
  }

  Future<void> edit_userData(String uniID, double newAmount) async {
    /*  _items.forEach((key, value) {
      if (uniID == key) {
        //print(value);
        Base_Summary uProf = value as Base_Summary;
        uProf.remamount = newAmount;
      }
    }); */
    try {
      final response = await http.patch(
          Uri.parse(
              "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$uniID/Summary.json"),
          body: jsonEncode({
            "ReqAmount": newAmount,
          }));
      /* print(response);
      print(response.body);
      print(response.statusCode); */
      var uProf = _items[uniID] as Base_Summary;
      int len = uProf.trandetails.length;

      if (len != 0) {
        var toAdd = newAmount -
            (uProf.trandetails[len - 1].aboutreq +
                uProf.trandetails[len - 1].paid_amount);

        uProf.trandetails.forEach((element) {
          element.aboutreq = element.aboutreq + toAdd;
        });
        uProf.remamount = uProf.remamount + toAdd;
      } else {
        uProf.remamount = newAmount;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }

    /* _items.update(uniID, (value) {
      Base_Summary uProf = value as Base_Summary;
      uProf.remamount = newAmount;
      return uProf.remamount;
    }); */
  }
}
