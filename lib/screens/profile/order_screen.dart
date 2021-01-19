import 'dart:math';

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

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  Future fetchAllOrders;
  bool _isInit = true;
  bool _showAnimation = false;

  AnimationController _controller;
  Animation<double> _opacityAnimation;
  Animation<Color> _colorAnimation;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.green).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad));
    _offsetAnimation = Tween<Offset>(begin: Offset(-5, -5), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
      backgroundColor: _colorAnimation.value,
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
                  : snapshot.data?.length == 0
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showAnimation = true;
          });
        },
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          curve: Curves.bounceInOut,
          opacity: _opacityAnimation.value,
          // height: _showAnimation ? 60 : 50,
          // width: _showAnimation ? 60 : 50,
          // color: Colors.white,
          child: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
