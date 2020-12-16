import 'package:flutter/material.dart';
import 'package:chito_shopping/provider/order_provider.dart' as oi;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderItem extends StatelessWidget {
  ThemeData themeConst;
  double mHeight, mWidth;
  final oi.OrderItem orderItem;
  OrderItem({@required this.orderItem});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    mHeight = mediaConst.size.height;
    mWidth = mediaConst.size.width;
    themeConst = Theme.of(context);
    return Card(
      child: ExpansionTile(
          title: Text(
            "Rs. ${orderItem.amount}",
            style: themeConst.textTheme.headline6
                .copyWith(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            orderItem.dateTime.toString(),
            style: TextStyle(color: Colors.black87),
          ),
          leading:
              Icon(FontAwesomeIcons.truckLoading, color: Colors.orangeAccent),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: orderItem.products.map((product) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: themeConst.textTheme.subtitle2
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Text("${product.quantity} x Rs. ${product.price} "),
              ],
            );
          }).toList()),
    );
  }
}
