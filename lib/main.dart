import 'package:chito_shopping/provider/order_provider.dart';
import 'package:chito_shopping/screens/bottom_overview_screen.dart';
import 'package:chito_shopping/screens/home/product_detail_screen.dart';
import 'package:chito_shopping/screens/home/product_list_screen.dart';
import 'package:chito_shopping/screens/profile/favourites_screen.dart';
import 'package:chito_shopping/screens/profile/order_screen.dart';
import 'package:chito_shopping/screens/user_product/edit_product_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return Products();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return Orders();
        }),
      ],
      child: MaterialApp(
        title: 'Chito Shopping',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          primaryColorLight: Colors.green,
          primaryColorDark: Colors.green,
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
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          ProductListScreen.routeName: (ctx) => ProductListScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
