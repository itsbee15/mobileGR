import 'package:first_flutter_project/pages/change_password.dart';
import 'package:first_flutter_project/pages/faq_page.dart';
import 'package:first_flutter_project/pages/home_page.dart';
import 'package:first_flutter_project/pages/profile_page.dart';
import 'package:first_flutter_project/pages/scanqr_page.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreen();
}

class _MyHomeScreen extends State<MyHomeScreen> {
   int _selectedIndex = 0;
   final PageController _pageController = PageController();
   final List<Widget> _pages = [
    
    HomePage(),
    ScanQrPage(),
    ProfilePage(),
    ChangePassword(),
    FAQPage(),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan GR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}