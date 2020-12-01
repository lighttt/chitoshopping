import 'package:chito_shopping/screens/bottom_overview_screen.dart';
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
          fontFamily: "Montserrat"),
      initialRoute: BottomOverviewScreen.routeName,
      routes: {BottomOverviewScreen.routeName: (ctx) => BottomOverviewScreen()},
    );
  }
}
