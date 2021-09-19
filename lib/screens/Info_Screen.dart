import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMDATA.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';

class Info_Screen extends StatelessWidget {
  String? _userID;

  Info_Screen(this._userID);
  @override
  Widget build(BuildContext context) {
    final _uniuser = Provider.of<BSummary>(context);
    final _user = _uniuser.items;
    Base_Summary _userDetails = _user[_userID] as Base_Summary;
    return Scaffold(
      appBar: AppBar(
        title: Text(_userDetails.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Name: ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Spacer(),
                    Text(
                      _userDetails.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Aadhar Number: ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Spacer(),
                    Text(
                      _userDetails.id,
                      style: Theme.of(context).textTheme.bodyText1,
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
