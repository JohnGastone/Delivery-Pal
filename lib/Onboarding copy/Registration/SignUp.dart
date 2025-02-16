// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:deliveryboy/Onboarding%20copy/Registration/RegistrationService.dart';
import 'package:deliveryboy/Onboarding%20copy/Registration/ValidationUtils.dart';
import 'package:deliveryboy/Onboarding%20copy/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliveryboy/Init.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _registrationService = RegistrationService();
  bool _isLoading = false;
  bool _autoValidate = false;
  bool isChecked = false;
  bool isObscured = true;
  bool isObscuredConfirm = true;

  // Default selected country code
  String selectedCountryCode = '+255';
  String selectedGender = 'Female';

  // List of country codes with flags
  final List<Map<String, String>> countryCodes = [
    {'code': '+255', 'flag': '🇹🇿'}, // Tanzania
    {'code': '+1', 'flag': '🇺🇸'}, // USA
    {'code': '+91', 'flag': '🇮🇳'}, // India
    {'code': '+44', 'flag': '🇬🇧'}, // UK
    {'code': '+254', 'flag': '🇰🇪'}, // Kenya
    {'code': '+234', 'flag': '🇳🇬'}, // Nigeria
    {'code': '+27', 'flag': '🇿🇦'}, // South Africa
  ];

  // List of genders
  final List<String> genders = ['Female', 'Male'];

  // Form controllers
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _dobController = TextEditingController();

  // Error handling helper
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Registration Error',
          style: GoogleFonts.poppins(fontSize: 22),
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Success handling helper
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text('Registration successful! Please login to continue.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignUp() async {
    setState(() => _autoValidate = true);

    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Combine country code and phone number
      final fullPhoneNumber =
          '$selectedCountryCode${_phoneController.text.trim()}';

      final result = await _registrationService.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        username: _userNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNo: fullPhoneNumber.replaceAll('+', ''), // Remove + symbol
        gender: selectedGender.toLowerCase(),
        plusCodeAddress: "$selectedCountryCode Dar es Salaam",
        password: _passwordController.text,
      );

      if (result['success']) {
        _showSuccessDialog();
      }
    } on ApiException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred. Please try again later.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Royal Oven",
                  style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(200, 91, 21, 21)),
                ),
                Text("Bakery & Cafe",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Color.fromARGB(200, 91, 21, 21))),
                SizedBox(
                  height: screenHeight * 0.02, // 50 Units of height
                ),
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                      color: Color.fromARGB(200, 91, 21, 21),
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _firstNameController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                validator: ValidationUtils.validateFirstName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "First Name",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _lastNameController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                validator: ValidationUtils.validateLastName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Last Name",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _userNameController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                validator: ValidationUtils.validateUsername,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "User Name",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: TextFormField(
                              controller: _dobController,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey),
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select your birth date";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Date of Birth (DD/MM)",
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.grey),
                                errorStyle: GoogleFonts.poppins(
                                    color: Color.fromARGB(200, 91, 21, 21),
                                    fontSize: 12),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.calendar_today,
                                      color: Colors.grey),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      helpText: "Select Date of Birth",
                                      fieldLabelText: "Enter Date",
                                      fieldHintText: "DD/MM",
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Color.fromARGB(
                                                  200, 91, 21, 21),
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
                                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}";
                                      setState(() {
                                        _dobController.text = formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _emailController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                keyboardType: TextInputType.emailAddress,
                                validator: ValidationUtils.validateEmail,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: Row(
                              children: [
                                DropdownButton<String>(
                                  value: selectedCountryCode,
                                  underline:
                                      SizedBox(), 
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCountryCode = newValue!;
                                    });
                                  },
                                  items: countryCodes
                                      .map((Map<String, String> country) {
                                    return DropdownMenuItem<String>(
                                      value: country['code'],
                                      child: Row(
                                        children: [
                                          Text(
                                            country['flag']!,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            country['code']!,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                // Phone number input field
                                Expanded(
                                    child: TextFormField(
                                  controller: _phoneController,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.grey),
                                  keyboardType: TextInputType.phone,
                                  validator: ValidationUtils.validatePhone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.grey),
                                    errorStyle: GoogleFonts.poppins(
                                        color: Color.fromARGB(200, 91, 21, 21),
                                        fontSize: 12),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        // Dropdown for gender
                        Container(
                          height: screenHeight * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            value: selectedGender,
                            underline:
                                SizedBox(), // Remove the default underline
                            icon:
                                Icon(Icons.arrow_drop_down, color: Colors.grey),
                            isExpanded:
                                true, // Ensure it spans the full width of the container
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: genders.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(
                                  gender,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _passwordController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                obscureText: isObscured,
                                validator: ValidationUtils.validatePassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscured = !isObscured;
                                      });
                                    },
                                    icon: Icon(
                                      isObscured
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        Container(
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey),
                                obscureText: isObscuredConfirm,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Color.fromARGB(200, 91, 21, 21),
                                      fontSize: 12),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscuredConfirm = !isObscuredConfirm;
                                      });
                                    },
                                    icon: Icon(
                                      isObscuredConfirm
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                InkWell(
                  onTap: _isLoading ? null : _handleSignUp,
                  child: Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(200, 91, 21, 21),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Create Account",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.28,
                        child: Divider(
                          color: Colors.grey,
                        )),
                    Text(
                      " Or Sign Up With ",
                      style:
                          GoogleFonts.poppins(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                        width: screenWidth * 0.28,
                        child: Divider(
                          color: Colors.grey,
                        )),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.05,
                        childAspectRatio:
                            1.5, // Adjust this to match your desired button proportions
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final socialLogins = [
                          {
                            'asset': './assets/google.png',
                            'name': 'Google',
                            'logoWidth': screenWidth * 0.1,
                            'logoHeight': screenHeight * 0.05,
                          },
                          {
                            'asset': './assets/fb.png',
                            'name': 'Facebook',
                          },
                          {
                            'asset': './assets/apple.png',
                            'name': 'Apple',
                          }
                        ];

                        final login = socialLogins[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                login['asset'] as String,
                                width: login['logoWidth'] as double? ??
                                    screenWidth * 0.05,
                                height: login['logoHeight'] as double? ??
                                    screenHeight * 0.03,
                              ),
                              SizedBox(width: 10),
                              Text(
                                login['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style:
                          GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: Text(
                        "Log In",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(200, 91, 21, 21),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1, // 50 Units of height
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => InitPage()));
                  },
                  child: Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(200, 91, 21, 21),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
