import 'package:flutter/material.dart';

import '../helper/firestore_helper.dart';

class CurrentDepartmentProvider extends ChangeNotifier {
  String _currentSelectedDepartment = '';

  String get currentSelectedDepartment => _currentSelectedDepartment;

  void setCurrentSelectedDepartment({required String selectedDepartment}) {
    _currentSelectedDepartment = selectedDepartment;
    // Update any other state if necessary
    notifyListeners();
  }
}
