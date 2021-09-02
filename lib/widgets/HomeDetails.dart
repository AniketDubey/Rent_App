import 'package:flutter/material.dart';
import 'package:rentapp/models/skeleton/Base_Summary.dart';
import 'package:rentapp/screens/Edit_Entry.dart';

import 'package:rentapp/screens/PersonalDetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMDATA.dart';

class HomeDetails extends StatefulWidget {
  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  void initState() {
    Provider.of<BSummary>(context, listen: false).fetchUsers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _uniuser = Provider.of<BSummary>(context);
    final _user = _uniuser.items;

    return Padding(
      padding: EdgeInsets.all(15),
      child: _user.length == 0
          ? EmptyScreen()
          : ListView.builder(
              itemBuilder: (ctx, index) {
                String _userID = _user.keys.elementAt(index);
                //print(_userID);
                Base_Summary _userDetails = _user[_userID] as Base_Summary;
                return Card(
                  child: InkWell(
                    onTap: () {
                      //print(_userID);
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
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      Edit_Entry(_userID, _userDetails),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          Spacer(),
                          Text(
                            _userDetails.trandetails.length == 0
                                ? "Rs. ${_userDetails.remamount.toInt()}"
                                : "Rs. ${_userDetails.trandetails.first.aboutreq.toInt()}",
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

Widget EmptyScreen() {
  return Center(
    child: Text(
      "Please share your amount!",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black45,
            offset: Offset(1.0, 2.0),
          ),
        ],
      ),
    ),
  );
}
