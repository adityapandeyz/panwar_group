// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../helper/firestore_helper.dart';
import '../models/employee.dart';
import '../models/firm.dart';
import '../provider/current_department_provider.dart';
import '../provider/current_firm_provider.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/dropdown_widgets.dart';

class AttendanceLogPage extends StatefulWidget {
  final bool viewOnly;
  final String firm;
  final String department;
  const AttendanceLogPage({
    Key? key,
    this.viewOnly = false,
    this.firm = '',
    this.department = '',
  }) : super(key: key);

  @override
  State<AttendanceLogPage> createState() => _AttendanceLogPageState();
}

class _AttendanceLogPageState extends State<AttendanceLogPage> {
  final FirestoreHelper firestoreHelper = FirestoreHelper();

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int selectedMonth = 2; // Default selection for January

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String? selectedFirm;
  String? selectedFirmId;

  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Log'),
        actions: [
          DropdownButton<int>(
            value: selectedMonth,
            onChanged: (int? newValue) {
              setState(() {
                selectedMonth = newValue!;
              });
            },
            items: List<DropdownMenuItem<int>>.generate(12, (index) {
              return DropdownMenuItem<int>(
                value: index + 1,
                child: Text(months[index]),
              );
            }),
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
                  padding: const EdgeInsets.all(12.0),
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
                        widget.firm.isEmpty
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Firm: '),
                                  FirmDropdown(),
                                ],
                              )
                            : const SizedBox(),
                        widget.firm.isEmpty
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Department: '),
                                  DepartmentDropdown(),
                                ],
                              )
                            : const SizedBox(),
                        StreamBuilder<List<Employee>>(
                          stream: firestoreHelper.getEmployeesStream(
                            selectedMonth,
                            widget.firm.isNotEmpty
                                ? widget.firm
                                : currentFirmProvider.currentSelectedFirm,
                            widget.department.isNotEmpty
                                ? widget.department
                                : currentDepartmentProvider
                                    .currentSelectedDepartment,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            List<Employee> allEmployees = snapshot.data ?? [];
                            List<Employee> displayedEmployees = allEmployees;

                            // Apply search filter
                            if (searchController.text.isNotEmpty) {
                              final searchTerm =
                                  searchController.text.toLowerCase();
                              displayedEmployees = allEmployees
                                  .where((employee) => employee.name
                                      .toLowerCase()
                                      .contains(searchTerm))
                                  .toList();
                            }

                            return ListView.builder(
                              itemCount: displayedEmployees.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Employee employee = displayedEmployees[index];
                                print(employee);

                                return Card(
                                  margin: const EdgeInsets.all(8.0),
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(employee.name),
                                        Text(
                                            '₹${employee.salaryPerUnit} / ${employee.salaryUnit}')
                                      ],
                                    ),
                                    trailing: !widget.viewOnly
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    FontAwesomeIcons
                                                        .indianRupeeSign),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddAdvancePopup(
                                                        employeeId:
                                                            employee.employeeId,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    FontAwesomeIcons.tshirt),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddClothTaken(
                                                        employeeId:
                                                            employee.employeeId,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    FontAwesomeIcons.arrowDown),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return MarkInAttendancePopup(
                                                        employeeId:
                                                            employee.employeeId,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    FontAwesomeIcons.arrowUp),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return MarkOutAttendancePopup(
                                                        employeeId:
                                                            employee.employeeId,
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        : const Text('View Only'),
                                    children: [
                                      TableCalendar(
                                        // customize the calendar as per your needs
                                        calendarFormat: CalendarFormat.month,
                                        pageAnimationEnabled: false,
                                        calendarBuilders:
                                            const CalendarBuilders(),
                                        startingDayOfWeek:
                                            StartingDayOfWeek.sunday,
                                        availableCalendarFormats: const {
                                          CalendarFormat.month: 'Month'
                                        },

                                        eventLoader: (date) {
                                          return employee.workingDays
                                                  .where((workingDay) =>
                                                      isSameDay(workingDay.date,
                                                          date))
                                                  .isNotEmpty
                                              ? [true]
                                              : [];
                                        },

                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime(2024),
                                        lastDay: DateTime(2050),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Total Full Working Days: ',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 16,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '${employee.totalFullWorkingDaysForTheMonth}',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Total Half Working Days: ',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 16,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '${employee.totalHalfWorkingDaysForTheMonth}',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Total Advance: ',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 16,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                            '₹${employee.totalAdvanceForTheMonth}',
                                            style: GoogleFonts.lato(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Cloth Taken:',
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                      ),
                                      DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Item')),
                                          DataColumn(label: Text('Qty')),
                                          DataColumn(label: Text('Rate')),
                                          DataColumn(label: Text('Amount')),
                                        ],
                                        rows: employee.workingDays
                                            .expand((workingDay) => workingDay
                                                    .clothTaken
                                                    .map((clothTaken) {
                                                  return DataRow(
                                                    cells: [
                                                      DataCell(
                                                        Text(clothTaken.cloth),
                                                      ),
                                                      DataCell(
                                                        Text(clothTaken.qty
                                                            .toString()),
                                                      ),
                                                      DataCell(
                                                        Text(clothTaken.rate
                                                            .toString()),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          (clothTaken.qty *
                                                                  clothTaken
                                                                      .rate)
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }))
                                            .toList(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Total Salary: ',
                                              style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                                fontSize: 18,
                                              ),
                                              softWrap: true,
                                            ),
                                            Text(
                                              '₹${employee.totalSalaryForTheMonth}',
                                              style: GoogleFonts.lato(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
          },
        );
      }),
    );
  }
}

class MarkInAttendancePopup extends StatefulWidget {
  final String employeeId;

  const MarkInAttendancePopup({super.key, required this.employeeId});
  @override
  _MarkInAttendancePopupState createState() => _MarkInAttendancePopupState();
}

class _MarkInAttendancePopupState extends State<MarkInAttendancePopup> {
  TextEditingController hoursWorkedController = TextEditingController();

  DateTime incomingTime = DateTime.now();

  Future<void> _selectIncomingTime(BuildContext context) async {
    TimeOfDay? selectedIncomingTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(incomingTime),
    );

    if (selectedIncomingTime != null) {
      setState(() {
        // Combine selected date with the chosen time
        incomingTime = DateTime(
          incomingTime.year,
          incomingTime.month,
          incomingTime.day,
          selectedIncomingTime.hour,
          selectedIncomingTime.minute,
        );
      });
    }
  }

  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  bool isHalfDay = true;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Mark In Attendance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Date',
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
                  DateFormat('dd-MM-yyyy').format(_date.toLocal()).toString(),
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
                    _selectDate(context);
                  },
                  icon: const Icon(FontAwesomeIcons.edit),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectIncomingTime(context),
              child: Text(
                'Incoming Time ${DateFormat('hh:mm a').format(incomingTime).toString()}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              markInAttendance(
                incomingTime,
                widget.employeeId,
                _date,
                isHalfDay,
              );

              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Mark'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    });
  }

  void markInAttendance(DateTime incomingTime, String employeeId, DateTime date,
      bool isHalfDay) async {
    FirestoreHelper firestoreHelper = FirestoreHelper();
    try {
      await firestoreHelper.markInAttendance(
        employeeId,
        incomingTime,
        // outgoingTime,
        date,
      );
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }
}

class MarkOutAttendancePopup extends StatefulWidget {
  final String employeeId;

  const MarkOutAttendancePopup({super.key, required this.employeeId});
  @override
  _MarkOutAttendancePopupState createState() => _MarkOutAttendancePopupState();
}

class _MarkOutAttendancePopupState extends State<MarkOutAttendancePopup> {
  TextEditingController hoursWorkedController = TextEditingController();

  DateTime outgoingTime = DateTime.now();

  Future<void> _selectOutgoingTime(BuildContext context) async {
    TimeOfDay? selectedOutgoingTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(outgoingTime),
    );

    if (selectedOutgoingTime != null) {
      setState(() {
        // Combine selected date with the chosen time
        outgoingTime = DateTime(
          outgoingTime.year,
          outgoingTime.month,
          outgoingTime.day,
          selectedOutgoingTime.hour,
          selectedOutgoingTime.minute,
        );
      });
    }
  }

  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  bool isHalfDay = true;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Mark Out Attendance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Date',
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
                  DateFormat('dd-MM-yyyy').format(_date.toLocal()).toString(),
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
                    _selectDate(context);
                  },
                  icon: const Icon(FontAwesomeIcons.edit),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectOutgoingTime(context),
              child: Text(
                'Outgoing Time ${DateFormat('hh:mm a').format(outgoingTime).toString()}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHalfDay = false;
                    });
                  },
                  child: Card(
                    color: !isHalfDay ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Full Day'),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHalfDay = true;
                    });
                  },
                  child: Card(
                    color: isHalfDay ? Colors.red : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Half Day'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              markOutAttendance(
                outgoingTime,
                widget.employeeId,
                _date,
                isHalfDay,
              );

              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Mark'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    });
  }

  void markInAttendance(
      DateTime incomingTime, String employeeId, DateTime date) async {
    FirestoreHelper firestoreHelper = FirestoreHelper();
    try {
      await firestoreHelper.markInAttendance(
        employeeId,
        incomingTime,
        date,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void markOutAttendance(DateTime outgoingTime, String employeeId,
      DateTime date, bool isHalfDay) async {
    FirestoreHelper firestoreHelper = FirestoreHelper();
    try {
      await firestoreHelper.markOutAttendance(
        employeeId,
        outgoingTime,
        date,
        isHalfDay,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

class AddAdvancePopup extends StatefulWidget {
  final String employeeId;

  const AddAdvancePopup({super.key, required this.employeeId});

  @override
  State<AddAdvancePopup> createState() => _AddAdvancePopupState();
}

class _AddAdvancePopupState extends State<AddAdvancePopup> {
  TextEditingController advanceController = TextEditingController();

  @override
  void dispose() {
    advanceController.dispose();
    super.dispose();
  }

  void setAdvace() {
    try {
      FirestoreHelper().addAdvance(
        widget.employeeId,
        double.parse(advanceController.text),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Add Advance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
              label: 'Advance Ammount (₹)',
              controller: advanceController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setAdvace();
              Navigator.of(context).pop();
            },
            child: const Text('Add Advance'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    });
  }
}

class AddClothTaken extends StatefulWidget {
  final String employeeId;

  const AddClothTaken({
    super.key,
    required this.employeeId,
  });

  @override
  State<AddClothTaken> createState() => _AddClothTakenState();
}

class _AddClothTakenState extends State<AddClothTaken> {
  TextEditingController clothNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  @override
  void dispose() {
    clothNameController.dispose();
    quantityController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Add Cloth Taken'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
              label: 'Cloth',
              controller: clothNameController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
              label: 'Quantity',
              controller: quantityController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextfield(
              label: 'Rate',
              controller: rateController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup

              try {
                FirestoreHelper().addClothTaken(
                  widget.employeeId,
                  clothNameController.text,
                  int.parse(quantityController.text),
                  double.parse(rateController.text),
                );
              } catch (e) {
                print(e);
              }
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    });
  }
}
