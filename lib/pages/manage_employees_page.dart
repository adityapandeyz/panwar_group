import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../helper/firestore_helper.dart';
import '../models/employee.dart';
import '../provider/current_department_provider.dart';
import '../provider/current_firm_provider.dart';
import '../widgets/add_employees.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/dropdown_widgets.dart';

class ManageEmployees extends StatefulWidget {
  const ManageEmployees({Key? key}) : super(key: key);

  @override
  State<ManageEmployees> createState() => _ManageEmployeesState();
}

class _ManageEmployeesState extends State<ManageEmployees> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirestoreHelper firestoreService = FirestoreHelper();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Employee> filteredEmployees = [];

  String? selectedFirm;
  String? selectedFirmId;

  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Manage Employees'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Dialog(
                    child: AddEmployeePopup(),
                  );
                },
              );
            },
            child: const Text('Add Employee'),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<CurrentFirmProvider>(
          builder: (context, currentFirmProvider, child) {
        return Consumer<CurrentDepartmentProvider>(
            builder: (context, currentDepartmentProvider, child) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 600,
                  child: Column(
                    children: [
                      CustomTextfield(
                        label: 'Search Employees',
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Firm: '),
                          FirmDropdown(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Department: '),
                          DepartmentDropdown(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      currentFirmProvider.currentFirmId == null &&
                              currentDepartmentProvider
                                  .currentSelectedDepartment.isEmpty
                          ? const Center(
                              child: Text('Select Firm and Department'),
                            )
                          : StreamBuilder<List<Employee>>(
                              stream: firestoreService.getEmployeesStream(
                                1,
                                currentFirmProvider.currentSelectedFirm,
                                currentDepartmentProvider
                                    .currentSelectedDepartment,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }

                                List<Employee> allEmployees = snapshot.data!;
                                filteredEmployees = allEmployees;

                                // Apply search filter
                                if (searchController.text.isNotEmpty) {
                                  final searchTerm =
                                      searchController.text.toLowerCase();
                                  filteredEmployees = allEmployees
                                      .where((employee) => employee.name
                                          .toLowerCase()
                                          .contains(searchTerm))
                                      .toList();
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredEmployees.length,
                                  itemBuilder: (context, index) {
                                    Employee employee =
                                        filteredEmployees[index];

                                    // Build your UI using employeeData
                                    return Card(
                                      child: ListTile(
                                        leading: const Icon(
                                          FontAwesomeIcons.person,
                                        ),
                                        title: Text(employee.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Age: ${employee.age}, Gender: ${employee.sex}'),
                                            Text(
                                                'Salary: ${employee.salaryPerUnit} / ${employee.salaryUnit}'),
                                            Text(
                                                'Position: ${employee.position} Department: ${employee.department}'),
                                            Text('Firm: ${employee.firm}'),
                                            Text(
                                                'Phone: ${employee.phoneNumber}, Email: ${employee.email}'),
                                            Text(
                                                'Address: ${employee.address}'),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon:
                                              const Icon(FontAwesomeIcons.edit),
                                          onPressed: () {
                                            // Add functionality for editing employee details
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Employee',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Dialog(
                child: AddEmployeePopup(),
              );
            },
          );
        },
        child: const Icon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }
}
