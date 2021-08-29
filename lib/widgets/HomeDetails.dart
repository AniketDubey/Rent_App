import 'package:flutter/material.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';

import 'package:rentapp/screens/PersonalDetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMDATA.dart';

class HomeDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _uniuser = Provider.of<BSummary>(context);
    final _user = _uniuser.items;

    return Padding(
      padding: EdgeInsets.all(15),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          String _userID = _user.keys.elementAt(index);
          Base_Summary _userDetails = _user[_userID] as Base_Summary;
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PersonalDetailsScreen(_userID),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      //"${_user[index].name}",
                      "${_userDetails.name}",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Spacer(),
                    Text(
                      "Rs. ${_userDetails.remamount.toInt()}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _user.length,
      ),
    );
  }
}
