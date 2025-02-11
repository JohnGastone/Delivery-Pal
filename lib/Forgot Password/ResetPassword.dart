// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import "package:deliveryboy/Onboarding%20copy/SignIn.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscureText = false;
  bool _obscureTextConfirm = false;

  void _showResetDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "./assets/illustration.png",
                  width: 250,
                  height: 200,
                ),
              ),
              Center(
                child: Text(
                  'Password Changed',
                  style: GoogleFonts.poppins(
                      fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password reset successfully you can now Login using the new password',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              Spacer(),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: InkWell(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(200, 91, 21, 21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SignInPage()));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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
              "Reset Password",
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
                  "Reset Password",
                  style: GoogleFonts.poppins(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Text(
                  "Your new password must be different from the last one you created",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 190),
                child:
                    Text("Password", style: GoogleFonts.poppins(fontSize: 20)),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    counter: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Must be at least 8 characters",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color.fromARGB(200, 91, 21, 21),
                        ),
                      ),
                    ),
                    counterStyle: GoogleFonts.poppins(
                        fontSize: 16, color: Color.fromARGB(200, 91, 21, 21)),
                    labelText: "***************",
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText; // Toggle visibility on tap
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Color.fromARGB(200, 91, 21, 21)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 115),
                child: Text("Confirm Password",
                    style: GoogleFonts.poppins(fontSize: 20)),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: _obscureTextConfirm,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    counter: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Both passwords must match",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color.fromARGB(200, 91, 21, 21),
                        ),
                      ),
                    ),
                    counterStyle: GoogleFonts.poppins(
                        fontSize: 16, color: Color.fromARGB(200, 91, 21, 21)),
                    labelText: "***************",
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureTextConfirm
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye),
                      onPressed: () {
                        setState(() {
                          _obscureTextConfirm =
                              !_obscureTextConfirm; // Toggle visibility on tap
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Color.fromARGB(200, 91, 21, 21)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: InkWell(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(200, 91, 21, 21),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Reset",
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    _showResetDialog();
                  },
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
