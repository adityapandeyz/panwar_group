import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/firestore_helper.dart';
import '../models/department.dart';
import '../models/firm.dart';
import '../provider/current_department_provider.dart';
import '../provider/current_firm_provider.dart';

class FirmDropdown extends StatefulWidget {
  const FirmDropdown({Key? key}) : super(key: key);

  @override
  State<FirmDropdown> createState() => _FirmDropdownState();
}

class _FirmDropdownState extends State<FirmDropdown> {
  final FirestoreHelper firestoreHelper = FirestoreHelper();

  String? selectedFirm;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentFirmProvider>(
      builder: (context, currentFirmProvider, child) =>
          StreamBuilder<List<Firm>>(
        stream: firestoreHelper.getFirmsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> firms = snapshot.data!
                .map((firm) => firm.name)
                .toList(); // Update the firms list

            return DropdownButton<String>(
              value: selectedFirm,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFirm = newValue!;
                  currentFirmProvider.setCurrentSelectedFirm(
                      selectedFirm: newValue);
                });
                print(newValue);
              },
              items: firms.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error loading firms: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class DepartmentDropdown extends StatefulWidget {
  const DepartmentDropdown({Key? key}) : super(key: key);

  @override
  State<DepartmentDropdown> createState() => _DepartmentDropdownState();
}

class _DepartmentDropdownState extends State<DepartmentDropdown> {
  String? selectedDepartment;
  final FirestoreHelper firestoreHelper = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    CurrentFirmProvider currentFirmProvider =
        Provider.of<CurrentFirmProvider>(context, listen: false);
    CurrentDepartmentProvider currentDepartmentProvider =
        Provider.of<CurrentDepartmentProvider>(context, listen: false);

    return Consumer<CurrentFirmProvider>(
        builder: (context, currentFirmProvider, child) => currentFirmProvider
                        .currentFirmId !=
                    null &&
                currentFirmProvider.currentFirmId!.isNotEmpty
            ? StreamBuilder<List<Department>>(
                stream: firestoreHelper
                    .getDepartmentStream(currentFirmProvider.currentFirmId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> departments = snapshot.data!
                        .map((department) => department.name)
                        .toList();
                    if (departments.isNotEmpty) {
                      return DropdownButton<String>(
                        value: selectedDepartment,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDepartment = newValue;
                            currentDepartmentProvider
                                .setCurrentSelectedDepartment(
                                    selectedDepartment: newValue!);
                          });
                        },
                        items: departments
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    } else {
                      return const Text('No departments available');
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error loading departments: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            : const Text('Select a Firm'));
  }
}
