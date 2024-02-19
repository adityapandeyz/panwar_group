// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'cloth_taken.dart';

class WorkingDay {
  final DateTime date;
  final DateTime incomingTime;
  final DateTime outgoingTime;
  final double advanceAmount;
  final List<ClothTaken> clothTaken;
  bool isHalfDay;

  WorkingDay({
    required this.date,
    required this.incomingTime,
    required this.outgoingTime,
    required this.advanceAmount,
    required this.clothTaken,
    required this.isHalfDay,
  });
}
