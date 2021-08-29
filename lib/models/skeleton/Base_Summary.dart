import 'package:rentapp/models/skeleton/transaction_summary.dart';

class Base_Summary {
  final String name;
  double remamount;
  List<Transaction> trandetails;

  Base_Summary({
    required this.name,
    required this.remamount,
    required this.trandetails,
  });
}
