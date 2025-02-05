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
    // Update the state with the new selected option
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
              Icon(
                CupertinoIcons.bell_fill,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: Color.fromARGB(200, 91, 21, 21))),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Branch Address",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: Color.fromARGB(200, 91, 21, 21),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "123 Main Street",
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Client Address",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: Color.fromARGB(200, 91, 21, 21),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "456 Minor Street",
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order Pickup Time",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.clock),
                                      Text(
                                        "8:00 AM",
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Time",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.clock),
                                      Text(
                                        "4:00 PM",
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Approx: ",
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                  Text(
                                    " 5 km",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: screenWidth * 0.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.22,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          )),
                                      child: Center(
                                        child: Text(
                                          "ACCEPT",
                                          style: GoogleFonts.poppins(
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.22,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          )),
                                      child: Center(
                                        child: Text(
                                          "REJECT",
                                          style: GoogleFonts.poppins(
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 1, color: Color.fromARGB(200, 91, 21, 21))),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Branch Address",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: Color.fromARGB(200, 91, 21, 21),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "123 Main Street",
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Client Address",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.location_solid,
                                    color: Color.fromARGB(200, 91, 21, 21),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "456 Minor Street",
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order Pickup Time",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.clock),
                                      Text(
                                        "8:00 AM",
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Time",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.clock),
                                      Text(
                                        "4:00 PM",
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Approx: ",
                                    style:
                                        GoogleFonts.poppins(color: Colors.grey),
                                  ),
                                  Text(
                                    " 5 km",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: screenWidth * 0.5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.22,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          )),
                                      child: Center(
                                        child: Text(
                                          "ACCEPT",
                                          style: GoogleFonts.poppins(
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeight * 0.05,
                                      width: screenWidth * 0.22,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          )),
                                      child: Center(
                                        child: Text(
                                          "REJECT",
                                          style: GoogleFonts.poppins(
                                            color:
                                                Color.fromARGB(200, 91, 21, 21),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.2,
                  )
                ],
              ),
            ),
          ),
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
                    width: screenWidth * 0.38, // Adjust width to match UI
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 1, color: Color(0xFF5B1515)),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.calendar_today,
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
                                    colorScheme: ColorScheme.light(
                                      primary: Color(
                                          0xFF5B1515), // Dark Red as in UI
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
                            Color(0xFF5B1515), // Custom color matching UI
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
                                ? Color.fromARGB(200, 91, 21, 21)
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
                                ? Color.fromARGB(200, 91, 21, 21)
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
          Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.4,
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
    return monthNames[month - 1]; // Convert month number to name
  }
}
