import 'package:flutter/material.dart';

class Transaction {
  final String Tid;
  final DateTime date;
  bool onMe = false;
  final double paid_amount;
  double aboutreq;

  Transaction({
    required this.onMe,
    required this.Tid,
    required this.date,
    required this.paid_amount,
    required this.aboutreq,
  });
}
