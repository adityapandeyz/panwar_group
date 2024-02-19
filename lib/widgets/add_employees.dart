import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/firestore_helper.dart';
import '../models/access_type.dart';
import '../models/department.dart';
import '../models/firm.dart';
import '../provider/current_department_provider.dart';
import '../provider/current_firm_provider.dart';
import '../utils/utils.dart';
import 'custom_textfield.dart';
import 'dropdown_widgets.dart';

class AddEmployeePopup extends StatelessWidget {
  const AddEmployeePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 600,
      width: 600,
      child: AddEmployeeWidget(),
    );
  }
}

class AddEmployeeWidget extends StatefulWidget {
  const AddEmployeeWidget({
    super.key,
  });

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController firmController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController salaryPerUnitController = TextEditingController();
  final TextEditingController salaryUnitController = TextEditingController();
  final TextEditingController joinedSinceController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    positionController.dispose();
    departmentController.dispose();
    firmController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    salaryPerUnitController.dispose();
    salaryUnitController.dispose();
    joinedSinceController.dispose();
    aadhaarController.dispose();

    super.dispose();
  }

  final FirestoreHelper firestoreService = FirestoreHelper();

  DateTime _joinedSince = DateTime.now();

  Future<void> _selectJoinedDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _joinedSince,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _joinedSince) {
      setState(() {
        _joinedSince = picked;
      });
    }
  }

  DateTime _dateOfBirth = DateTime.now();

  Future<void> _selectDateOfBirthDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  String gender = 'Male';
  String salaryUnit = 'Day';
  String? selectedFirm;
  String? selectedDepartment;
  String? selectedFirmId;

  UserType userType = UserType.none;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Employee'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            buildTextField("Name", nameController),
            // buildTextField("Gender", genderController),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text('Gender:'),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      gender = 'Male';
                    });
                  },
                  child: Card(
                    color: gender == 'Male' ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Male'),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      gender = 'Female';
                    });
                  },
                  child: Card(
                    color: gender == 'Female' ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Female'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            buildTextField("Position", positionController),
            Row(
              children: [
                const Text('UserType:'),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              userType = UserType.none;
                            });
                          },
                          child: Card(
                            color: userType == UserType.none
                                ? Colors.red
                                : Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('None'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              userType = UserType.viewer;
                            });
                          },
                          child: Card(
                            color: userType == UserType.viewer
                                ? Colors.red
                                : Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Viewer'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              userType = UserType.logger;
                            });
                          },
                          child: Card(
                            color: userType == UserType.logger
                                ? Colors.red
                                : Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Logger'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              userType = UserType.admin;
                            });
                          },
                          child: Card(
                            color: userType == UserType.admin
                                ? Colors.red
                                : Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Admin'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text('Firm: '),
                FirmDropdown(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text('Department: '),
                DepartmentDropdown(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            buildTextField("Email", emailController),
            buildTextField("Phone Number", phoneNumberController),
            buildTextField("Aadhaar", aadhaarController),
            buildTextField("Address", addressController),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Salary Unit:'),
                const SizedBox(
                  width: 10,
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       salaryUnit = 'Hour';
                //     });
                //   },
                //   child: Card(
                //     color: salaryUnit == 'Hour' ? Colors.red : Colors.white,
                //     child: const Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Center(
                //         child: Text('Hour'),
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    setState(() {
                      salaryUnit = 'Day';
                    });
                  },
                  child: Card(
                    color: salaryUnit == 'Day' ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Day'),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      salaryUnit = 'Month';
                    });
                  },
                  child: Card(
                    color: salaryUnit == 'Month' ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Month'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            buildTextField("Salary Per Unit", salaryPerUnitController),

            Text(
              'Joining Date',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(_joinedSince.toLocal())
                      .toString(),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    _selectJoinedDate(context);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.edit,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Date of Birth',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy')
                      .format(_dateOfBirth.toLocal())
                      .toString(),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    _selectDateOfBirthDate(context);
                  },
                  icon: const Icon(FontAwesomeIcons.edit),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text("Add"),
          onPressed: () async {
            Navigator.pop(context);

            if (nameController.text.isEmpty ||
                positionController.text.isEmpty ||
                emailController.text.isEmpty ||
                phoneNumberController.text.isEmpty ||
                addressController.text.isEmpty ||
                salaryPerUnitController.text.isEmpty) {
              return;
            }

            try {
              double salaryPerUnit = double.parse(salaryPerUnitController.text);
              CurrentFirmProvider currentFirmProvider =
                  Provider.of<CurrentFirmProvider>(context, listen: false);
              CurrentDepartmentProvider currentDepartmentProvider =
                  Provider.of<CurrentDepartmentProvider>(context,
                      listen: false);
              // Create a map with employee data
              Map<String, dynamic> employeeData = {
                'name': nameController.text.trim(),
                'Gender': gender,
                'position': positionController.text.trim(),
                'department':
                    currentDepartmentProvider.currentSelectedDepartment,
                'firm': currentFirmProvider.currentSelectedFirm,
                'email': emailController.text.trim(),
                'phoneNumber': int.parse(phoneNumberController.text.trim()),
                'address': addressController.text.trim(),
                'salaryPerUnit': salaryPerUnit,
                'salaryUnit': salaryUnit,
                'joinedSince': _joinedSince,
                'dateOfBirth': _dateOfBirth,
                'aadhaar': aadhaarController.text.trim(),
                'userType': userType.toString()
              };

              // Add employee data to Firestore
              await firestoreService.addEmployee(employeeData);

              if (userType != UserType.none) {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: aadhaarController.text.trim(),
                );
              }
              nameController.clear();
              positionController.clear();
              emailController.clear();
              phoneNumberController.clear();
              addressController.clear();
              salaryPerUnitController.clear();
            } catch (e) {
              showAlert(context, e.toString());
            }
          },
        ),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomTextfield(
        controller: controller,
        label: label,
      ),
    );
  }
}
