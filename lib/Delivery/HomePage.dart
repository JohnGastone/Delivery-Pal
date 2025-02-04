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
  final _datePickerController = TextEditingController();

  String _formatTodayDate() {
    DateTime now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)} ${now.year}";
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
                "Delivery",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Picker Container
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.36, // Adjust width to match UI
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 1, color: Color(0xFF5B1515)),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.grey),
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
                                    primary:
                                        Color(0xFF5B1515), // Dark Red as in UI
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
                                "${pickedDate.day.toString().padLeft(2, '0')} "
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
          )
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
