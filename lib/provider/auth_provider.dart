import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/firestore_helper.dart';
import '../models/access_type.dart';
import '../pages/attendance_log_page.dart';
import '../pages/front_page.dart';
import '../pages/home_page.dart';
import '../utils/utils.dart';

class AdminAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserType currentUserType = UserType.viewer;

  Future<void> loginUser(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot userSnapshot = await _firestore
          .collection('employees')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userData = userSnapshot.docs.first;
        String userTypeString = userData.get('userType');
        String userFirm = userData.get('firm');
        String userDept = userData.get('department');

        currentUserType = FirestoreHelper().getUserType(userTypeString);

        if (currentUserType == UserType.admin) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ),
          );
        } else if (currentUserType == UserType.logger) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AttendanceLogPage(
                firm: userFirm,
                department: userDept,
              ),
            ),
          );
        } else if (currentUserType == UserType.viewer) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AttendanceLogPage(
                viewOnly: true,
                firm: userFirm,
                department: userDept,
              ),
            ),
          );
        } else {}
      } else {
        // showAlert(context, "User not found");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      }
    } catch (e) {
      showAlert(
        context,
        e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> logoutAdmin(context) async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const FrontPage(),
          ),
          (route) => false);
    } catch (e) {
      showAlert(context, e.toString());
    }
    notifyListeners();
  }
}
