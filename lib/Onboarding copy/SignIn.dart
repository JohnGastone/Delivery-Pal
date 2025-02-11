// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:deliveryboy/Forgot%20Password/ForgotPassword.dart';
import 'package:deliveryboy/Init.dart';
import 'package:deliveryboy/Onboarding%20copy/Registration/SignUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 600 && size.width <= 1024;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 500
                  : isTablet
                      ? 600
                      : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 40 : 15),
              child: _buildContent(size, isDesktop, isTablet),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Size size, bool isDesktop, bool isTablet) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeader(isDesktop, isTablet),
          SizedBox(height: size.height * 0.06),
          _buildLoginForm(size, isDesktop, isTablet),
          SizedBox(height: size.height * 0.03),
          _buildSocialLogin(size, isDesktop, isTablet),
          SizedBox(height: size.height * 0.03),
          _buildSignUpSection(size, isDesktop, isTablet),
          SizedBox(height: size.height * 0.03),
          _buildGuestButton(size, isDesktop, isTablet),
        ],
      );

  Widget _buildHeader(bool isDesktop, bool isTablet) => Column(
        children: [
          Text(
            "Royal Oven",
            style: GoogleFonts.poppins(
              fontSize: isDesktop
                  ? 48
                  : isTablet
                      ? 45
                      : 42,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(200, 91, 21, 21),
            ),
          ),
          Text(
            "Bakery & Cafe",
            style: GoogleFonts.poppins(
              fontSize: isDesktop
                  ? 22
                  : isTablet
                      ? 20
                      : 18,
              color: const Color.fromARGB(200, 91, 21, 21),
            ),
          ),
        ],
      );

  Widget _buildLoginForm(Size size, bool isDesktop, bool isTablet) => Column(
        children: [
          Text(
            "Log in",
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(200, 91, 21, 21),
              fontSize: isDesktop
                  ? 36
                  : isTablet
                      ? 34
                      : 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          _buildInputField(
            size,
            isDesktop,
            icon: CupertinoIcons.mail,
            hint: "Email",
          ),
          SizedBox(height: size.height * 0.015),
          _buildPasswordField(size, isDesktop),
          _buildRememberMeRow(),
          SizedBox(height: size.height * 0.015),
          _buildSignInButton(size, isDesktop, isTablet),
          SizedBox(height: size.height * 0.015),
          _buildForgotPasswordLink(isDesktop),
        ],
      );

  Widget _buildInputField(
    Size size,
    bool isDesktop, {
    required IconData icon,
    required String hint,
  }) =>
      Container(
        height: isDesktop ? size.height * 0.07 : size.height * 0.06,
        width: isDesktop ? 400 : size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDesktop
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: TextField(
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.grey),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: isDesktop ? 17 : 15,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );

  Widget _buildPasswordField(Size size, bool isDesktop) => Container(
        height: isDesktop ? size.height * 0.07 : size.height * 0.06,
        width: isDesktop ? 400 : size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDesktop
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 5),
          child: TextField(
            obscureText: isObscured,
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(CupertinoIcons.lock, color: Colors.grey),
              hintText: "Password",
              hintStyle: GoogleFonts.poppins(
                fontSize: isDesktop ? 17 : 15,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => isObscured = !isObscured),
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildRememberMeRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            side: const BorderSide(color: Colors.grey),
            activeColor: const Color.fromARGB(200, 91, 21, 21),
            onChanged: (value) => setState(() => isChecked = value ?? false),
          ),
          Text(
            "Remember Me",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
        ],
      );

  Widget _buildSignInButton(Size size, bool isDesktop, bool isTablet) =>
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: isDesktop
              ? size.height * 0.06
              : isTablet
                  ? size.height * 0.05
                  : size.height * 0.04,
          width: isDesktop ? 300 : size.width * 0.4,
          decoration: BoxDecoration(
            color: const Color.fromARGB(200, 91, 21, 21),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDesktop
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              "Sign In",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: isDesktop ? 18 : 16,
              ),
            ),
          ),
        ),
      );

  Widget _buildForgotPasswordLink(bool isDesktop) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPassword()),
        ),
        child: Text(
          "Forgot your password",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(200, 91, 21, 21),
            fontSize: isDesktop ? 20 : 18,
          ),
        ),
      );

  Widget _buildSocialLogin(Size size, bool isDesktop, bool isTablet) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: isDesktop ? 120 : size.width * 0.25,
                child: const Divider(color: Colors.grey),
              ),
              Text(
                " Or Continue With ",
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 19 : 17,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: isDesktop ? 120 : size.width * 0.25,
                child: const Divider(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          _buildSocialButtons(size, isDesktop),
        ],
      );

  Widget _buildSocialButtons(Size size, bool isDesktop) {
    final socialLogins = [
      {
        'asset': './assets/google.png',
        'name': 'Google',
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

    return SizedBox(
      width: isDesktop ? 500 : size.width * 0.9, // Constrain overall width
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Even spacing between buttons
        children: socialLogins.map((login) {
          return Container(
            width:
                isDesktop ? 140 : size.width * 0.26, // Slightly reduced width
            height: isDesktop ? 50 : size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(24), // Increased border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              // Clip the content to respect border radius
              borderRadius: BorderRadius.circular(24),
              child: Material(
                // Add material for better touch feedback
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    // Handle login
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        login['asset'] as String,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        login['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSignUpSection(Size size, bool isDesktop, bool isTablet) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 20 : 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: size.width * 0.05),
          InkWell(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SignUpPage()),
            ),
            child: Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(200, 91, 21, 21),
              ),
            ),
          ),
        ],
      );

  Widget _buildGuestButton(Size size, bool isDesktop, bool isTablet) => InkWell(
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const InitPage()),
        ),
        child: Container(
          height: isDesktop
              ? size.height * 0.07
              : isTablet
                  ? size.height * 0.06
                  : size.height * 0.05,
          width: isDesktop ? 400 : size.width * 0.5,
          decoration: BoxDecoration(
            color: const Color.fromARGB(200, 91, 21, 21),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDesktop
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              "Continue as a guest",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: isDesktop ? 18 : 16,
              ),
            ),
          ),
        ),
      );
}
