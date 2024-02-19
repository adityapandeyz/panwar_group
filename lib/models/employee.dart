// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'access_type.dart';
import 'cloth_taken.dart';
import 'working_day.dart';

class Employee {
  final String name;
  final int age;
  final String sex;
  final String employeeId;
  final String position;
  final String department;
  final String firm;
  final String email;
  final String phoneNumber;
  final String address;
  final double salaryPerUnit;
  final String salaryUnit;
  final DateTime joinedSince;
  List<WorkingDay> workingDays;
  List<ClothTaken> clothTaken;
  final int vacationBalance;
  final int sickLeaveBalance;
  final UserType userType;
  final DateTime dateOfBirth;
  final String aadhaar;
  final int totalFullWorkingDaysForTheMonth;
  final int totalHalfWorkingDaysForTheMonth;

  final double totalSalaryForTheMonth;
  final double totalAdvanceForTheMonth;

  Employee({
    List<WorkingDay>? workingDays,
    required this.name,
    required this.age,
    required this.sex,
    required this.employeeId,
    required this.position,
    required this.department,
    required this.firm,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.salaryPerUnit,
    required this.salaryUnit,
    required this.joinedSince,
    required this.clothTaken,
    required this.vacationBalance,
    required this.sickLeaveBalance,
    required this.userType,
    required this.dateOfBirth,
    required this.aadhaar,
    required this.totalFullWorkingDaysForTheMonth,
    required this.totalHalfWorkingDaysForTheMonth,
    required this.totalSalaryForTheMonth,
    required this.totalAdvanceForTheMonth,
  }) : this.workingDays = workingDays ?? <WorkingDay>[];

  void addWorkingDay(WorkingDay workingDay) {
    workingDays.add(workingDay);
  }
}
