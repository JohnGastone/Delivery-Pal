import 'package:deliveryboy/Forgot%20Password/CodeVerification.dart';
import 'package:deliveryboy/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  int _radioValue = -1;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _radioValue = _prefs.getInt('selectedResetMethodIndex') ?? -1;
    });
  }

  void _handleRadioValueChange(int? value) {
    if (value != null) {
      setState(() {
        _radioValue = value;
      });
      _prefs.setInt('selectedResetMethodIndex', value);
      final selectedMethod = ResetMethodModelData.displayResetMethods[value];
      _prefs.setString('selectedResetMethod', selectedMethod.resetMethod ?? '');
      _prefs.setString(
          'selectedResetPlaceholder', selectedMethod.resetPlaceholder ?? '');
    }
  }

  void _continueToVerification() {
    if (_radioValue != -1) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const CodeVerificationPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a reset method')),
      );
    }
  }

  Widget _buildResetMethodCard(
      ResetMethodsModel resetMethod, int index, double cardWidth) {
    return Column(
      children: [
        InkWell(
          onTap: () => _handleRadioValueChange(index),
          child: Container(
            width: cardWidth,
            constraints: const BoxConstraints(minHeight: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _radioValue == index
                    ? const Color.fromARGB(200, 91, 21, 21)
                    : const Color.fromARGB(200, 91, 21, 21).withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  resetMethod.resetMethodIcon ?? const Icon(Icons.error),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resetMethod.resetMethod ?? 'Unknown Method',
                          style: GoogleFonts.poppins(
                              fontSize: 17, color: Colors.grey),
                        ),
                        Text(
                          resetMethod.resetPlaceholder ?? 'No placeholder',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Radio<int>(
                    activeColor: const Color.fromARGB(200, 91, 21, 21),
                    focusColor: Colors.grey,
                    value: index,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 1024;
    final isTablet = screenSize.width > 600 && screenSize.width <= 1024;

    // Responsive measurements
    final contentWidth = isDesktop
        ? screenSize.width * 0.4
        : isTablet
            ? screenSize.width * 0.6
            : screenSize.width * 0.85;

    final contentPadding = isDesktop
        ? EdgeInsets.symmetric(horizontal: screenSize.width * 0.3)
        : isTablet
            ? EdgeInsets.symmetric(horizontal: screenSize.width * 0.2)
            : EdgeInsets.symmetric(horizontal: screenSize.width * 0.075);

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: SingleChildScrollView(
          padding: contentPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.05),
              Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                  fontSize: isDesktop
                      ? 40
                      : isTablet
                          ? 35
                          : 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.02),
              Text(
                "Select which contact method we should use to send you password reset code",
                style: GoogleFonts.poppins(
                  fontSize: isDesktop
                      ? 20
                      : isTablet
                          ? 18
                          : 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.05),
              Container(
                constraints: BoxConstraints(maxHeight: screenSize.height * 0.5),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ResetMethodModelData.displayResetMethods.length,
                  itemBuilder: (context, index) {
                    return _buildResetMethodCard(
                      ResetMethodModelData.displayResetMethods[index],
                      index,
                      contentWidth,
                    );
                  },
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              InkWell(
                onTap: _continueToVerification,
                child: Container(
                  width: isDesktop
                      ? 250
                      : isTablet
                          ? 220
                          : 200,
                  height: isDesktop
                      ? 60
                      : isTablet
                          ? 55
                          : 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(200, 91, 21, 21),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop
                            ? 22
                            : isTablet
                                ? 20
                                : 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
