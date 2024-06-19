import 'package:first_flutter_project/pages/home_page.dart';
import 'package:first_flutter_project/pages/profile_page.dart';
import 'package:first_flutter_project/pages/scanqr_page.dart';
import 'package:flutter/material.dart';

class ButtonNavigation extends StatefulWidget{
  const ButtonNavigation ({Key ? key}) : super(key: key);

  @override
  _ButtonNavigation createState() => _ButtonNavigation();
}

class _ButtonNavigation extends State<ButtonNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    
    HomePage(),
    ScanQrPage(),
    ProfilePage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}