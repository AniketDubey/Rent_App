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
    _items.forEach((key, value) {
      value as Base_Summary;
      value.trandetails.sort((a, b) {
        return -a.date.compareTo(b.date);
      });
    });

    return _items;
  }

  Base_Summary findByID(String uniID) {
    return _items[uniID] as Base_Summary;
  }

  Future<void> del_User(String UID) async {
    Base_Summary saveUser = _items[UID] as Base_Summary;
    _items.remove(UID);
    try {
      final response = await http.delete(
        Uri.parse(
            "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$UID.json"),
      );

      if (response.statusCode >= 400) {
        _items[UID] = saveUser;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> add_Trans(String id, double amount, DateTime pickdate) async {
    Base_Summary _userprofile = items[id] as Base_Summary;

    double updatedamount = 0;
    if (_userprofile.trandetails.length == 0) {
      updatedamount = _userprofile.remamount - amount;
    } else {
      updatedamount = _userprofile.trandetails[0].aboutreq - amount;
    }

    final url = Uri.parse(
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary/Transaction.json");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(
          {
            "Date": pickdate.toString(),
            "Paid Amount": amount,
            "Remaining": updatedamount,
          },
        ),
      );

      res = await http.patch(
          Uri.parse(
              "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary.json"),
          body: json.encode({
            "ReqAmount": updatedamount,
          }));
    } catch (error) {}

    _items.clear();
    await fetchUsers();
  }

  Future<void> Add_NewMember(Map<String, Object> _enteredDetails) async {
    if (_items.containsKey(_enteredDetails["Aadhar"])) return;

    final url = Uri.parse(
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users.json");

    try {
      final res = await http.post(
        url,
        body: jsonEncode(
          {
            "uniID": "${_enteredDetails["Aadhar"]}",
            "Summary": {
              "ID": "${_enteredDetails["Aadhar"]}",
              "Name": _enteredDetails["Name"],
              "ReqAmount": _enteredDetails["ReqAmount"],
              "Transaction": [],
            },
          },
        ),
      );
    } catch (error) {}
    await fetchUsers();

    notifyListeners();
  }

  Future<void> fetchUsers() async {
    const url =
        "https://rent-management-b2488-default-rtdb.firebaseio.com/Users.json";

    try {
      final response = await http.get(Uri.parse(url));

      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((key, value) {
        List<Transaction> _uTrans = [];

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
                  id: value["Summary"]["ID"],
                  name: value["Summary"]["Name"].toString(),
                  remamount: value["Summary"]["ReqAmount"] as double,
                  trandetails: _uTrans,
                ));
      });
    } catch (error) {}

    notifyListeners();
  }

  Future<void> del_Trans(String id, String tid) async {
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
    await http.patch(
        Uri.parse(
            "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary.json"),
        body: json.encode({
          "ReqAmount": _userprofile.trandetails[0].aboutreq,
        }));

    notifyListeners();

    try {
      var response = await http.delete(Uri.parse(
          "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary/Transaction/$tid.json"));

      if (response.statusCode >= 400) {
        if (expecIndex != 0) {
          for (var i = 0; i < expecIndex; i++) {
            _userprofile.trandetails[i].aboutreq -= presentAmount;
          }
        }

        _userprofile.trandetails.insert(expecIndex, savedValue);

        notifyListeners();
      }
      await http.patch(
          Uri.parse(
              "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$id/Summary.json"),
          body: json.encode({
            "ReqAmount": _userprofile.trandetails[0].aboutreq,
          }));
      savedValue = null;
    } catch (error) {
      print(error);
    }
  }

  Future<void> edit_userData(String uniID, double newAmount) async {
    try {
      final response = await http.patch(
          Uri.parse(
              "https://rent-management-b2488-default-rtdb.firebaseio.com/Users/$uniID/Summary.json"),
          body: jsonEncode({
            "ReqAmount": newAmount,
          }));

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
  }
}
