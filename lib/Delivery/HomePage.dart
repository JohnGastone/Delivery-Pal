import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAvailable = false;
  String _selectedOption = 'New Orders'; //
  final _datePickerController = TextEditingController();

  String _formatTodayDate() {
    DateTime now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)} ${now.year}";
  }

  void _toggleSelectedOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(200, 91, 21, 21),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hello Martin!",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Icon(
                CupertinoIcons.bell_fill,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. SingleChildScrollView (Bottom-most)
          Positioned.fill(
            // Use Positioned.fill to make it take all available space
            top: screenHeight * 0.2,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // Your Containers Here (the ones that should scroll)
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(200, 91, 21, 21))),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child:
                            ColumnContent(), // A simplified column to hold the widgets
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(200, 91, 21, 21))),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: ColumnContent(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Date Picker and Availability Switch (Middle)
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Picker Container
                  Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.38,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border:
                          Border.all(width: 1, color: const Color(0xFF5B1515)),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(CupertinoIcons.calendar_today,
                              size: 20, color: Colors.grey),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              helpText: "Select Date",
                              fieldLabelText: "Enter Date",
                              fieldHintText: "DD/MM/YYYY",
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Color(0xFF5B1515),
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day.toString().padLeft(2)} "
                                  "${_getMonthName(pickedDate.month)} "
                                  "${pickedDate.year}"; // Format similar to UI
                              setState(() {
                                _datePickerController.text = formattedDate;
                              });
                            }
                          },
                        ),
                        Text(
                          _datePickerController.text.isEmpty
                              ? _formatTodayDate() // Placeholder as seen in UI
                              : _datePickerController.text,
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // Availability Switch
                  Row(
                    children: [
                      Text(
                        "Are you available?",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black),
                      ),
                      Switch(
                        value: isAvailable,
                        activeColor:
                            const Color(0xFF5B1515), // Custom color matching UI
                        onChanged: (bool value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. New Orders/Active Orders Toggle (Top-most)
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 196, 195, 195)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // New Orders button
                      GestureDetector(
                        onTap: () => _toggleSelectedOption('New Orders'),
                        child: Container(
                          width: screenWidth * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _selectedOption == 'New Orders'
                                ? const Color.fromARGB(200, 91, 21, 21)
                                : const Color.fromARGB(255, 196, 195, 195),
                          ),
                          child: Center(
                            child: Text(
                              "New Orders",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: _selectedOption == 'New Orders'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Active Orders button
                      GestureDetector(
                        onTap: () => _toggleSelectedOption('Active Orders'),
                        child: Container(
                          width: screenWidth * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _selectedOption == 'Active Orders'
                                ? const Color.fromARGB(200, 91, 21, 21)
                                : const Color.fromARGB(255, 196, 195, 195),
                          ),
                          child: Center(
                            child: Text(
                              "Active Orders",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: _selectedOption == 'Active Orders'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const List<String> monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return monthNames[month - 1];
  }
}

class ColumnContent extends StatelessWidget {
  const ColumnContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddressText(title: "Branch Address", address: "123 Main Street"),
        SizedBox(height: 10),
        AddressText(title: "Client Address", address: "456 Minor Street"),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeColumn(title: "Order Pickup Time", time: "8:00 AM"),
            TimeColumn(title: "Delivery Time", time: "4:00 PM"),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        DistanceAndActions(),
      ],
    );
  }
}

class AddressText extends StatelessWidget {
  const AddressText({
    super.key,
    required this.title,
    required this.address,
  });

  final String title;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
        ),
        Row(
          children: [
            const Icon(
              CupertinoIcons.location_solid,
              color: Color.fromARGB(200, 91, 21, 21),
            ),
            const SizedBox(width: 8),
            Text(
              address,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}

class TimeColumn extends StatelessWidget {
  const TimeColumn({
    super.key,
    required this.title,
    required this.time,
  });

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Icon(CupertinoIcons.clock),
            Text(
              time,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}

class DistanceAndActions extends StatelessWidget {
  const DistanceAndActions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Row(
          children: [
            Text(
              "Approx: ",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
            Text(
              " 5 km",
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: screenWidth * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: screenHeight * 0.05,
                width: screenWidth * 0.22,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(200, 91, 21, 21))),
                child: Center(
                  child: Text(
                    "ACCEPT",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(200, 91, 21, 21),
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.05,
                width: screenWidth * 0.22,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(200, 91, 21, 21))),
                child: Center(
                  child: Text(
                    "REJECT",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(200, 91, 21, 21),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
