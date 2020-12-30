import 'package:chito_shopping/provider/order_provider.dart' show Orders;
import 'package:chito_shopping/widgets/empty_order_widget.dart';
import 'package:chito_shopping/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "/order_screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future fetchAllOrders;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      fetchAllOrders =
          Provider.of<Orders>(context, listen: false).fetchAllAndSetOrders();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: fetchAllOrders,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.hasError
                  ? Center(
                      child: Text("Something went wrong!"),
                    )
                  : snapshot.data.length == 0
                      ? EmptyOrder(type: "Order")
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          itemBuilder: (context, i) {
                            return OrderItem(
                              orderItem: snapshot.data[i],
                            );
                          },
                          itemCount: snapshot.data.length,
                        );
        },
      ),
    );
  }
}
