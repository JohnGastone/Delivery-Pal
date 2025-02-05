import 'package:deliveryboy/Delivery/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            bottom: 0,
            left: 1,
            right: 1,
            child: ClipRRect(
              child: BottomNavigationBar(
                selectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.bold),
                unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 0
                              ? const Color.fromARGB(200, 91, 21, 21)
                              : const Color.fromARGB(255, 33, 31, 31),
                          BlendMode.srcIn),
                      child: Image.asset(
                        "./assets/order.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 1
                              ? const Color.fromARGB(200, 91, 21, 21)
                              : const Color.fromARGB(255, 33, 31, 31),
                          BlendMode.srcIn),
                      child: Image.asset(
                        "./assets/bike.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    label: 'Deliveries',
                  ),
                  BottomNavigationBarItem(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          _selectedIndex == 2
                              ? const Color.fromARGB(200, 91, 21, 21)
                              : const Color.fromARGB(255, 33, 31, 31),
                          BlendMode.srcIn),
                      child: Icon(CupertinoIcons.person),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color.fromARGB(200, 91, 21, 21),
                unselectedItemColor: const Color.fromARGB(255, 33, 31, 31),
                onTap: _onItemTapped,
                elevation: 10,

                // ✅ Hide labels for unselected items
                showSelectedLabels: true,
                showUnselectedLabels: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
