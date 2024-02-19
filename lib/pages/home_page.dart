import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../widgets/custom_page.dart';
import '../widgets/custom_square.dart';
import 'attendance_log_page.dart';
import 'manage_employees_page.dart';
import 'manage_firms_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAuthProvider>(
      builder: (context, provider, child) {
        return CustomPage(
          isShowLogout: true,
          widget: ListView(
            shrinkWrap: true,
            children: [
              CustomSquare(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const AttendanceLogPage(),
                    ),
                  );
                },
                icon: FontAwesomeIcons.fileCircleCheck,
                title: 'Attendance Log',
              ),
              CustomSquare(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ManageEmployees(),
                    ),
                  );
                },
                icon: FontAwesomeIcons.peopleGroup,
                title: 'Manage Employees',
              ),
              CustomSquare(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ManageFirmsPage(),
                    ),
                  );
                },
                icon: FontAwesomeIcons.buildingCircleCheck,
                title: 'Manage Firms',
              ),
            ],
          ),
        );
      },
    );
  }
}
