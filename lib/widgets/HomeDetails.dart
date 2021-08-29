import 'package:flutter/material.dart';

import 'package:rentapp/models/data/DUMMYDATA.dart';
import 'package:rentapp/screens/PersonalDetailsScreen.dart';
import 'package:provider/provider.dart';

class HomeDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _uniuser = Provider.of<BSummary>(context);
    final _user = _uniuser.items;

    return Padding(
      padding: EdgeInsets.all(15),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PersonalDetailsScreen(_user[index].id),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "${_user[index].name}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      flex: 3,
                      fit: FlexFit.tight,
                    ),
                    Flexible(
                      child: Text(
                        "${_user[index].remamount.toInt()}",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      flex: 1,
                      fit: FlexFit.tight,
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
