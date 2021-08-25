import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMMYDATA.dart';

import 'screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BSummary(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Rent Management",
        theme: ThemeData(
          cardTheme: CardTheme(
            color: Colors.blue,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
