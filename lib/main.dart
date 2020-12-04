import 'package:chito_shopping/screens/bottom_overview_screen.dart';
import 'package:chito_shopping/screens/product/product_detail_screen.dart';
import 'package:chito_shopping/screens/product/product_list_screen.dart';
import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chito Shopping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent.shade200,
        primaryColorLight: Colors.redAccent.shade200,
        primaryColorDark: Colors.redAccent.shade200,
        accentColor: Color(0xFFF7B733),
        canvasColor: Colors.white,
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24)),
        ),
      ),
      initialRoute: BottomOverviewScreen.routeName,
      routes: {
        BottomOverviewScreen.routeName: (ctx) => BottomOverviewScreen(),
        ProductListScreen.routeName: (ctx) => ProductListScreen(),
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}
