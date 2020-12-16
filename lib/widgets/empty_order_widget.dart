import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyOrder extends StatelessWidget {
  final String type;

  EmptyOrder({@required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 75),
      child: Center(
        child: Column(
          children: [
            Lottie.asset(
              type == "Cart"
                  ? "assets/images/empty_box.json"
                  : "assets/images/empty_order.json",
              fit: BoxFit.contain,
              repeat: false,
            ),
            Text(
              type == "Cart"
                  ? "You don't have any items in cart. Please add now!"
                  : "You haven't ordered anything. Start ordering now!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
