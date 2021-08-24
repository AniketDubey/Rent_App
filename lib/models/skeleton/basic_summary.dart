import 'package:flutter/material.dart';

import 'package:rentapp/models/skeleton/transaction_summary.dart';

class BasicSummary {
  final String id;
  final String name;
  final double remamount;
  final List<Transaction> trandetails;

  const BasicSummary({
    required this.id,
    required this.name,
    required this.remamount,
    required this.trandetails,
  });
}
