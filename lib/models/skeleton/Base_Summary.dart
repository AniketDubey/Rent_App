import 'package:rentapp/models/skeleton/transaction_summary.dart';

class Base_Summary {
  final String id;
  final String name;
  double remamount;
  List<Transaction> trandetails;

  Base_Summary({
    required this.id,
    required this.name,
    required this.remamount,
    required this.trandetails,
  });
}
