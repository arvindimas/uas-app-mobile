import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/pengeluaran.dart';
import 'package:flutter_application_1/pages/pemasukan.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/login.dart'; // Import the login page

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorPalette.light100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Home'),
            _buildNavItem(1, Icons.remove, 'Pengeluaran'),
            _buildNavItem(2, Icons.add, 'Pemasukan'),
            _buildNavItem(3, Icons.logout, 'Logout'), // Add a logout button
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconData, String label) {
    return InkWell(
      onTap: () {
        if (index == 3) {
          // Logout button tapped
          _logout(context);
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _currentIndex == index ? ColorPalette.dark25 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: _currentIndex == index ? ColorPalette.light100 : Colors.grey,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index ? ColorPalette.light100 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return PengeluaranPage();
      case 2:
        return PemasukanPage();
      default:
        return Container(); // Placeholder for additional pages
    }
  }

  // Function to handle logout
  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
