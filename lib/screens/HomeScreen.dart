import 'package:flutter/material.dart';
import 'package:rentapp/models/data/DUMDATA.dart';
import 'package:rentapp/screens/Add_NewEntry.dart';

import 'package:rentapp/widgets/HomeDetails.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _submit_NewData(Map<String, Object> _savedInfo) {
      Provider.of<BSummary>(context, listen: false).Add_NewMember(_savedInfo);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => Add_NewEntry(_submit_NewData),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: HomeDetails(),
    );
  }
}
