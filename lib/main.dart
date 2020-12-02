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
        primaryColor: Color(0xFFF77866),
        accentColor: Color(0xFFF7B733),
        canvasColor: Colors.white,
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFFF77866),
          ),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: blackColor,
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
