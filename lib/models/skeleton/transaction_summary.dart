import 'package:flutter/material.dart';

class Transaction {
  final DateTime date;
  final double paid_amount;

  const Transaction({
    required this.date,
    required this.paid_amount,
  });
}
