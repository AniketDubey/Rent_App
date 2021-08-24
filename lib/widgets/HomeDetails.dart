import 'package:flutter/material.dart';

import 'package:rentapp/models/data/DUMMYDATA.dart';
import 'package:rentapp/models/skeleton/basic_summary.dart';
import 'package:rentapp/screens/PersonalDetailsScreen.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          PersonalDetailsScreen(DUMMYDATA[index].id),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "${DUMMYDATA[index].name}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        flex: 3,
                        fit: FlexFit.tight,
                      ),
                      Flexible(
                        child: Text(
                          "${DUMMYDATA[index].remamount}",
                          style: Theme.of(context).textTheme.bodyText1,
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
          itemCount: DUMMYDATA.length,
        ));
  }
}
