import 'package:chito_shopping/screens/home_screen.dart';
import 'package:chito_shopping/screens/message_screen.dart';
import 'package:chito_shopping/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';

class BottomOverviewScreen extends StatefulWidget {
  static const String routeName = "/bottom_overview_screen";

  @override
  _BottomOverviewScreenState createState() => _BottomOverviewScreenState();
}

class _BottomOverviewScreenState extends State<BottomOverviewScreen> {
  /// Current Page
  int _selectedPageIndex = 0;

  // Change the index
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  /// Get the current page
  Widget _getCurrentPage() {
    switch (_selectedPageIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return CartScreen();
      case 2:
        return MessageScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeConst = Theme.of(context);
    return Scaffold(
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        currentIndex: _selectedPageIndex,
        selectedItemColor: themeConst.primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xFF727C8E),
        onTap: (index) => _selectPage(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "Profile"),
        ],
      ),
    );
  }
}
