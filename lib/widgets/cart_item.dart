import 'package:chito_shopping/provider/cart_provider.dart' show Cart;
import 'package:chito_shopping/provider/products_provider.dart';
import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  ThemeData themeConst;
  double mHeight, mWidth;

  final String id;
  final String title;
  final int quantity;
  final String cartId;
  CartItem({@required this.id, this.title, this.quantity, this.cartId});

  @override
  Widget build(BuildContext context) {
    themeConst = Theme.of(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mHeight = mediaQueryData.size.height;
    mWidth = mediaQueryData.size.width;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findProductById(cartId);
    final cartProvider = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        cartProvider.removeItem(cartId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (dCtx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Do you want remove this item from cart?"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(dCtx, false);
                      },
                      child: Text("No"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(dCtx, true);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ));
      },
      child: Container(
        height: mHeight * 0.17,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  child: Image.network(
                    loadedProduct.imageURL,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: themeConst.textTheme.subtitle1
                                .copyWith(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rs. ${loadedProduct.price * quantity}",
                            style: themeConst.textTheme.subtitle2.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.minimize,
                              color: themeConst.primaryColor,
                            ),
                            onPressed: () {
                              cartProvider.removeSingleItem(cartId);
                            }),
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: greyColor)),
                            child: Text("$quantity")),
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              Icons.add,
                              color: themeConst.primaryColor,
                            ),
                            onPressed: () {
                              cartProvider.addToCart(cartId, title,
                                  loadedProduct.price * quantity);
                            })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
