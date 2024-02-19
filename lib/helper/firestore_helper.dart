import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/access_type.dart';
import '../models/cloth_taken.dart';
import '../models/department.dart';
import '../models/employee.dart';
import '../models/firm.dart';
import '../models/working_day.dart';

class FirestoreHelper {
  final CollectionReference employeesCollection =
      FirebaseFirestore.instance.collection('employees');

  final CollectionReference firmsCollection =
      FirebaseFirestore.instance.collection('firms');

  Future<void> addEmployee(Map<String, dynamic> employeeData) async {
    await employeesCollection.add(employeeData);
  }

  Stream<List<Employee>> getEmployeesStream(
      int monthNum, String firm, String department) {
    return employeesCollection
        .where('firm', isEqualTo: firm)
        .where('department', isEqualTo: department)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<Employee> employeesList = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Fetch attendance data for all months
        var yearCollection = employeesCollection
            .doc(doc.id)
            .collection('attendance')
            .doc('2024'); // Assuming '2024' is a document, not a subcollection

        // Fetch all day documents within the year collection
        var monthCollection = yearCollection.collection(
            monthNum.toString()); // Assuming '1' is a subcollection for January

        // Iterate through each day within the month collection
        var dayDocuments = await monthCollection.get();

        List<WorkingDay> workingDays = [];
        int totalFullWorkingDays = 0;
        int totalHalfWorkingDays = 0;

        double totalAdvance = 0.0;
        double totalClothTakenAmount =
            0.0; // To store the total amount for cloth taken

        for (QueryDocumentSnapshot dayDocument in dayDocuments.docs) {
          var workingDay = WorkingDay(
            incomingTime: (dayDocument['incomingTime'] as Timestamp).toDate(),
            outgoingTime: (dayDocument['outgoingTime'] as Timestamp).toDate(),
            date: (dayDocument['date'] as Timestamp).toDate(),
            advanceAmount: dayDocument['advanceAmount']?.toDouble(),
            clothTaken: (dayDocument['clothTaken'] as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map((clothData) => ClothTaken.fromMap(clothData))
                .toList(),
            isHalfDay: dayDocument['isHalfDay'],
          );

          if (workingDay.isHalfDay) {
            totalHalfWorkingDays += 1;
          } else {
            totalFullWorkingDays +=
                1; // Fix: Increment totalFullWorkingDays for full-day
          }

          totalAdvance += workingDay.advanceAmount;
          workingDays.add(workingDay);

          totalClothTakenAmount +=
              workingDay.clothTaken.fold(0.0, (sum, cloth) {
            return sum + (cloth.qty * cloth.rate);
          });
        }

        double totalSalaryForTheMonth = (((data['salaryUnit'] == 'Day')
                    ? (totalHalfWorkingDays * (data['salaryPerUnit'] / 2) +
                        totalFullWorkingDays * data['salaryPerUnit'])
                    : data['salaryPerUnit']) -
                totalAdvance) -
            totalClothTakenAmount;

        Employee employee = Employee(
          name: data['name'] ?? '',
          age: data['age'] ?? 0,
          sex: data['Gender'] ?? '',
          employeeId: doc.id,
          salaryPerUnit: data['salaryPerUnit'] ?? 0.0,
          joinedSince: (data['joinedSince'] as Timestamp).toDate(),
          workingDays: workingDays,
          // ... (rest of the Employee initialization)
          position: data['position'],
          department: data['department'],
          firm: data['firm'],
          email: data['email'],
          phoneNumber: data['phoneNumber'].toString(),
          address: data['address'],
          salaryUnit: data['salaryUnit'],
          vacationBalance: 0,
          sickLeaveBalance: 0,
          userType: getUserType(data['userType']),
          dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
          aadhaar: data['aadhaar'],
          totalFullWorkingDaysForTheMonth: totalFullWorkingDays,
          totalHalfWorkingDaysForTheMonth: totalHalfWorkingDays,
          totalAdvanceForTheMonth: totalAdvance,
          totalSalaryForTheMonth: totalSalaryForTheMonth,
          clothTaken: [],
        );

        employeesList.add(employee);
      }

      return employeesList;
    });
  }

  UserType getUserType(String userTypeString) {
    switch (userTypeString) {
      case 'UserType.admin':
        return UserType.admin;
      case 'UserType.viewer':
        return UserType.viewer;
      case 'UserType.logger':
        return UserType.logger;
      case 'UserType.none':
        return UserType.none;
      default:
        throw ArgumentError('Invalid userTypeString');
    }
  }

  Future<void> markInAttendance(
      String employeeId, DateTime incomingTime, DateTime date) async {
    try {
      // Extract year, month, and day from the current date
      int year = date.year;
      int month = date.month;
      int day = date.day;

      // Reference to the attendance collection
      var attendanceCollection = FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeId)
          .collection('attendance');

      // Reference to the specific year, month, and day subcollections
      var yearCollection = attendanceCollection.doc(year.toString());
      var monthCollection = yearCollection.collection(month.toString());
      var dayCollection = monthCollection.doc(day.toString());

      // Update the attendance data for the employee in the specific day
      await dayCollection.set({
        'employeeId': employeeId,
        'incomingTime': incomingTime,
        'outgoingTime': DateTime.now(),
        'date': date,
        'advanceAmount': 0.0,
        'isHalfDay': false,
        'clothTaken': [],
      });
    } catch (e) {
      print('Error marking attendance: $e');
    }
  }

  Future<void> markOutAttendance(String employeeId, DateTime outgoingTime,
      DateTime date, bool isHalfday) async {
    try {
      // Extract year, month, and day from the current date
      int year = date.year;
      int month = date.month;
      int day = date.day;

      // Reference to the attendance collection
      var attendanceCollection = FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeId)
          .collection('attendance');

      // Reference to the specific year, month, and day subcollections
      var yearCollection = attendanceCollection.doc(year.toString());
      var monthCollection = yearCollection.collection(month.toString());
      var dayCollection = monthCollection.doc(day.toString());

      // Update the attendance data for the employee in the specific day
      await dayCollection.update({
        // 'employeeId': employeeId,
        // 'incomingTime': incomingTime,
        'outgoingTime': outgoingTime,
        // 'date': date,
        'advanceAmount': 0.0,
        'isHalfDay': isHalfday,
      });
    } catch (e) {
      print('Error marking attendance: $e');
    }
  }

  Future<void> addAdvance(String employeeId, double advanceAmount) async {
    try {
      DateTime today = DateTime.now();

      // Extract year, month, and day from the current date
      int year = today.year;
      int month = today.month;
      int day = today.day;

      // Reference to the attendance collection
      var attendanceCollection = FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeId)
          .collection('attendance');

      // Reference to the specific year, month, and day subcollections
      var yearCollection = attendanceCollection.doc(year.toString());
      var monthCollection = yearCollection.collection(month.toString());
      var dayCollection = monthCollection.doc(day.toString());

      // Update the attendance data for the employee in the specific day
      await dayCollection.update({
        'advanceAmount': advanceAmount,
      });
    } catch (e) {
      print('Error adding advance: $e');
    }
  }

  Future<void> addClothTaken(
    String employeeId,
    String cloth,
    int qty,
    double rate,
  ) async {
    try {
      DateTime today = DateTime.now();

      // Extract year, month, and day from the current date
      int year = today.year;
      int month = today.month;
      int day = today.day;

      // Reference to the attendance collection
      var attendanceCollection = FirebaseFirestore.instance
          .collection('employees')
          .doc(employeeId)
          .collection('attendance');

      // Reference to the specific year, month, and day subcollections
      var yearCollection = attendanceCollection.doc(year.toString());
      var monthCollection = yearCollection.collection(month.toString());
      var dayCollection = monthCollection.doc(day.toString());

      // Update the attendance data for the employee in the specific day
      await dayCollection.update({
        'clothTaken': FieldValue.arrayUnion([
          {
            'cloth': cloth,
            'rate': rate,
            'qty': qty,
          }
        ]),
      });
    } catch (e) {
      print('Error adding cloth taken: $e');
    }
  }

  Stream<List<Firm>> getFirmsStream() {
    return firmsCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Firm(
          name: data['name'],
          firmId: doc.id,
          gstin: data['gstin'],
          address: data['address'],
        );
      }).toList();
    });
  }

  Future<String?> getFirmIdWithName(String firmName) async {
    String? firmId;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('firms')
        .where('name', isEqualTo: firmName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's only one document for a given firm name
      DocumentSnapshot doc = querySnapshot.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      firmId = doc
          .id; // Replace 'firmId' with the actual field name in your Firestore document
    }

    return firmId;
  }

  Stream<List<Department>> getDepartmentStream(String firmId) {
    return FirebaseFirestore.instance
        .collection('firms')
        .doc(firmId)
        .collection('departments')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Department(
          name: data['name'],
          id: doc.id,
        );
      }).toList();
    });
  }
}
