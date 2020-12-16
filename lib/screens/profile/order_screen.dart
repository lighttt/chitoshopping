import 'package:chito_shopping/provider/order_provider.dart' show Orders;
import 'package:chito_shopping/widgets/empty_order_widget.dart';
import 'package:chito_shopping/widgets/order_item.dart';
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
      body: orderList.length == 0
          ? EmptyOrder(type: "Order")
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemBuilder: (context, i) {
                return OrderItem(
                  orderItem: orderList[i],
                );
              },
              itemCount: orderList.length,
            ),
    );
  }
}
