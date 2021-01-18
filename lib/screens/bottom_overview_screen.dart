import 'dart:io';

import 'package:chito_shopping/provider/auth_provider.dart';
import 'package:chito_shopping/provider/products_provider.dart';
import 'package:chito_shopping/screens/user_product/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';
import 'cart/cart_screen.dart';
import 'home/custom_search_delegate.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'user_product/user_product_screen.dart';

class BottomOverviewScreen extends StatefulWidget {
  static const String routeName = "/bottom_overview_screen";

  @override
  _BottomOverviewScreenState createState() => _BottomOverviewScreenState();
}

class _BottomOverviewScreenState extends State<BottomOverviewScreen> {
  /// Current Page
  int _selectedPageIndex = 0;
  ThemeData themeConst;
  Future _getAllProducts;

  // Change the index
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _getCurrentAppBar() {
    switch (_selectedPageIndex) {
      case 0:
        return AppBar(
          title: Image.asset(
            "assets/images/app_logo_hori.png",
            height: 40,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            )
          ],
          backgroundColor: themeConst.primaryColor,
        );
      case 1:
        return AppBar(
          title: Text("My Cart"),
          backgroundColor: themeConst.primaryColor,
        );
      case 2:
        return AppBar(
          title: Text(
            "My Products",
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName);
                })
          ],
          backgroundColor: themeConst.primaryColor,
        );
      case 3:
        return AppBar(
          title: Text("My Profile", style: TextStyle(color: Colors.white)),
          backgroundColor: themeConst.primaryColor,
        );
      default:
        return AppBar(title: Text("My Cart"));
    }
  }

  /// Get the current page
  Widget _getCurrentPage() {
    switch (_selectedPageIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return CartScreen();
      case 2:
        return UserProductScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  Future<void> getProducts() async {
    try {
      await Provider.of<Products>(context, listen: false).fetchAllProducts();
    } on HttpException {
      await Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllProducts = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    themeConst = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          themeConst.primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      appBar: _getCurrentAppBar(),
      body: FutureBuilder(
        future: _getAllProducts,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _getCurrentPage();
        },
      ),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: "My Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "Profile"),
        ],
      ),
    );
  }
}
