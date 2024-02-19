import 'package:flutter/material.dart';

import '../helper/firestore_helper.dart';

class CurrentFirmProvider extends ChangeNotifier {
  String _currentSelectedFirm = '';
  String? _currentFirmId;

  String get currentSelectedFirm => _currentSelectedFirm;
  String? get currentFirmId => _currentFirmId;

  final FirestoreHelper firestoreHelper = FirestoreHelper();

  void setCurrentSelectedFirm({required String selectedFirm}) async {
    _currentSelectedFirm = selectedFirm;
    _currentFirmId =
        await getCurrentFirmId(); // Wait for the future to complete
    notifyListeners();
    print(_currentFirmId);
  }

  Future<String?> getCurrentFirmId() async {
    var currentFirmId =
        await firestoreHelper.getFirmIdWithName(_currentSelectedFirm);
    return currentFirmId;
  }
}
