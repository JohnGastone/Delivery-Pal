// ignore_for_file: deprecated_member_use

import 'package:deliveryboy/Onboarding/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 600 && size.width <= 1024;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 215, 178),
      body: Stack(
        children: [
          _buildBackgroundImage(size),
          _buildGradientOverlay(size),
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : double.infinity,
                  minHeight: size.height,
                ),
                child: _buildContent(size, isDesktop, isTablet),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(Size size) => Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./assets/cake3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _buildGradientOverlay(Size size) => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color.fromARGB(200, 91, 21, 21),
              const Color.fromARGB(200, 91, 21, 21).withOpacity(0.9),
            ],
          ),
        ),
      );

  Widget _buildContent(Size size, bool isDesktop, bool isTablet) {
    final contentWidth = isDesktop
        ? size.width * 0.4
        : isTablet
            ? size.width * 0.6
            : size.width * 0.8;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isDesktop ? size.height * 0.4 : size.height * 0.05),
          Image.asset(
            'assets/delivery.png',
            height: isDesktop
                ? size.height * 0.35 // Adjust height based on screen size
                : isTablet
                    ? size.height * 0.3
                    : size.height * 0.25,
            width: isDesktop
                ? size.width * 0.3 // Adjust width accordingly
                : isTablet
                    ? size.width * 0.4
                    : size.width * 0.5,
            fit: BoxFit.cover,
          ),
          SizedBox(height: isDesktop ? size.height * 0.4 : size.height * 0.05),
          _buildTitle(isDesktop, isTablet),
          SizedBox(height: size.height * 0.02),
          _buildSubtitle(isDesktop, isTablet, contentWidth),
          SizedBox(height: size.height * 0.04),
          _buildGetStartedButton(size, isDesktop, isTablet, contentWidth),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }

  Widget _buildTitle(bool isDesktop, bool isTablet) => Center(
        child: Text(
          "Royal Oven's Delivery \nPal", // Removed unnecessary spaces
          textAlign: TextAlign.center, // Centers text properly
          style: GoogleFonts.poppins(
            fontSize: isDesktop
                ? 64
                : isTablet
                    ? 52
                    : 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildSubtitle(bool isDesktop, bool isTablet, double contentWidth) =>
      Container(
        width: contentWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Go online, accept your orders and make customers happy with your services.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isDesktop
                ? 24
                : isTablet
                    ? 20
                    : 15,
            color: Colors.white,
          ),
        ),
      );

  Widget _buildGetStartedButton(
          Size size, bool isDesktop, bool isTablet, double contentWidth) =>
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SignInPage()),
            );
          },
          child: Container(
            height: isDesktop
                ? size.height * 0.07
                : isTablet
                    ? size.height * 0.06
                    : size.height * 0.05,
            width: contentWidth * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (isDesktop)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
              ],
            ),
            child: Center(
              child: Text(
                "Go Online",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 91, 21, 21),
                  fontSize: isDesktop
                      ? 28
                      : isTablet
                          ? 26
                          : 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}
