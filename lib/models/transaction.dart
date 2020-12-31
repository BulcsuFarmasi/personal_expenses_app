import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double ammout;
  final DateTime date;

  Transaction({@required this.id, @required this.title, @required this.ammout, @required this.date});
}
