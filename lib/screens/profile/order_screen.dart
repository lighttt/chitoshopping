import 'package:chito_shopping/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order_screen";

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return Text("$i");
        },
        itemCount: orderList.length,
      ),
    );
  }
}
