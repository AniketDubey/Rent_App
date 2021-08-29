import 'package:flutter/material.dart';

class Transaction {
  final DateTime date;
  final double paid_amount;
  final double aboutreq;

  Transaction({
    required this.date,
    required this.paid_amount,
    required this.aboutreq,
  });
}
