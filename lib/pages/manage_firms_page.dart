import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/firestore_helper.dart';
import '../models/department.dart';
import '../models/firm.dart';
import '../widgets/custom_textfield.dart';

class ManageFirmsPage extends StatefulWidget {
  const ManageFirmsPage({super.key});

  @override
  State<ManageFirmsPage> createState() => _ManageFirmsPageState();
}

class _ManageFirmsPageState extends State<ManageFirmsPage> {
  TextEditingController firmController = TextEditingController();
  TextEditingController gstinController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final FirestoreHelper firestoreService = FirestoreHelper();
  TextEditingController departmentNameController = TextEditingController();

  List<Firm> filteredFirms = [];

  @override
  void dispose() {
    firmController.dispose();
    searchController.dispose();
    gstinController.dispose();
    phoneController.dispose();
    addressController.dispose();
    departmentNameController.dispose();
    super.dispose();
  }

  String selectedFirm = 'Firm Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Firms'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showAddFirmDialog();
            },
            child: const Text('Add Firm'),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: StreamBuilder<List<Firm>>(
            stream: firestoreService.getFirmsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              List<Firm> allFirms = snapshot.data!;
              filteredFirms = allFirms;

              // Apply search filter
              if (searchController.text.isNotEmpty) {
                final searchTerm = searchController.text.toLowerCase();
                filteredFirms = allFirms
                    .where(
                        (firm) => firm.name.toLowerCase().contains(searchTerm))
                    .toList();
              }

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          label: 'Search Firms',
                          controller: searchController,
                          onChanged: (valule) {
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredFirms.length,
                            itemBuilder: (context, index) {
                              Firm firm = filteredFirms[index];

                              return Card(
                                child: ListTile(
                                  leading: const Icon(
                                    FontAwesomeIcons.building,
                                  ),
                                  title: Text(firm.name),
                                  // trailing: IconButton(
                                  //   icon: const Icon(FontAwesomeIcons.edit),
                                  //   onPressed: () {},
                                  // ),
                                  trailing: ElevatedButton(
                                    child: const Text('Add Depart.'),
                                    onPressed: () {
                                      showAddDepartmentDialog(firm.firmId);
                                    },
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('GSTIN: ${firm.gstin}'),
                                      Text(firm.address),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Departments: ',
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder<List<Department>>(
                                        stream: firestoreService
                                            .getDepartmentStream(firm.firmId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<String> departments = snapshot
                                                .data!
                                                .map((department) =>
                                                    department.name)
                                                .toList();

                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: departments.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  elevation: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        departments[index]),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddFirmDialog();
        },
        child: const Icon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }

  void showAddFirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Firm'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  label: 'Firm Name',
                  controller: firmController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  label: 'GSTIN',
                  controller: gstinController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  label: 'Phone No',
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  label: 'Address',
                  controller: addressController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (firmController.text.isEmpty) {
                    return;
                  }
                  FirebaseFirestore.instance.collection('firms').doc().set({
                    'name': firmController.text,
                    'gstin': gstinController.text,
                    'phone': phoneController.text,
                    'address': addressController.text,
                  });
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showAddDepartmentDialog(String firmId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Department'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                label: 'Department Name',
                controller: departmentNameController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (departmentNameController.text.isEmpty) {
                    return;
                  }
                  FirebaseFirestore.instance
                      .collection('firms')
                      .doc(firmId)
                      .collection('departments')
                      .doc()
                      .set({
                    'name': departmentNameController.text.trim(),
                  });
                  departmentNameController.clear();
                } catch (e) {
                  print(e);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
