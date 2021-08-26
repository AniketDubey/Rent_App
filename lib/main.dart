import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentapp/models/data/DUMMYDATA.dart';
import 'package:rentapp/screens/Add_Transaction_Screen.dart';
import 'package:rentapp/widgets/HomeDetails.dart';

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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor.withOpacity(1),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
