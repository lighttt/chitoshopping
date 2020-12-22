import 'package:chito_shopping/provider/cart_provider.dart' show Cart;
import 'package:chito_shopping/provider/order_provider.dart';
import 'package:chito_shopping/theme/constants.dart';
import 'package:chito_shopping/widgets/cart_item.dart';
import 'package:chito_shopping/widgets/empty_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ThemeData themeConst;
  double mHeight, mWidth;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    themeConst = Theme.of(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mHeight = mediaQueryData.size.height;
    mWidth = mediaQueryData.size.width;
    final cartProvider = Provider.of<Cart>(context);
    final cartMap = cartProvider.items;
    final orderProvider = Provider.of<Orders>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        scrollDirection: Axis.vertical,
        child: cartProvider.totalCount == 0
            ? EmptyOrder(
                type: "Cart",
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mHeight * 0.68,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      itemBuilder: (context, i) => CartItem(
                        cartId: cartMap.keys.toList()[i],
                        id: cartMap.values.toList()[i].id,
                        title: cartMap.values.toList()[i].title,
                        quantity: cartMap.values.toList()[i].quantity,
                      ),
                      itemCount: cartProvider.totalCount,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: accentColor.withOpacity(0.1),
                      border:
                          Border.all(color: themeConst.primaryColor, width: 2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text("Total:",
                                  style: themeConst.textTheme.subtitle1
                                      .copyWith(
                                          fontSize: 15, color: greyColor)),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Rs. ${cartProvider.totalAmount}",
                                  style: themeConst.textTheme.headline5
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await orderProvider.addOrder(
                                        cartMap.values.toList(),
                                        cartProvider.totalAmount);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    cartProvider.clearCart();
                                  },
                            child: _isLoading
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Text(
                                    "Checkout",
                                  ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: themeConst.primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
