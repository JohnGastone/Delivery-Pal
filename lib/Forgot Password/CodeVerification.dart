// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import "package:deliveryboy/Forgot%20Password/ForgotPassword.dart";
import "package:deliveryboy/Forgot%20Password/ResetPassword.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  Timer? _timer;
  int _start = 120;
  bool _isTimerRunning = true; // New state variable to track timer state
  List<FocusNode> _focusNodes = [];
  List<TextEditingController> _controllers = [];
  String _verificationDestination = '';

  @override
  void initState() {
    super.initState();
    startTimer();
    _loadVerificationDetails();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
  }

  Future<void> _loadVerificationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final placeholder = prefs.getString('selectedResetPlaceholder') ?? '';

    setState(() {
      _verificationDestination = placeholder;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
          _isTimerRunning =
              false; // Update the state to indicate timer has timed out
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String get timerText {
    if (_start == 0) {
      return 'Time out, try again';
    }
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (index == _focusNodes.length - 1 && value.isNotEmpty) {
      _focusNodes[index].unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Text(
              "OTP",
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  "Code Verification",
                  style: GoogleFonts.poppins(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Enter verification code sent to: ",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.grey),
                        ),
                        TextSpan(
                          text: _verificationDestination,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Color.fromARGB(200, 91, 21, 21),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) => _onTextChanged(index, value),
                        enabled:
                            _isTimerRunning, // Disable the text field if the timer has timed out
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromARGB(200, 91, 21, 21)),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Resend Code in ",
                      style:
                          GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      CupertinoIcons.clock,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      timerText,
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Color.fromARGB(200, 91, 21, 21)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: InkWell(
                  onTap: _isTimerRunning
                      ? () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ResetPasswordPage()),
                          );
                        }
                      : null, // Disable the tap when timer is not running
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isTimerRunning
                          ? Color.fromARGB(200, 91, 21, 21)
                          : Colors.grey, // Change color when disabled
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 30),
                child: Row(
                  children: [
                    Text(
                      "Did'nt receive code?",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      child: Text("Resend",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Color.fromARGB(200, 91, 21, 21))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}
