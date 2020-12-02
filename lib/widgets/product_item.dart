import 'package:chito_shopping/screens/product/product_detail_screen.dart';
import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imgUrl;
  final double price;
  final String title;

  const ProductItem({this.imgUrl, this.price, this.title});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double mHeight = mediaQuery.size.height;
    double mWidth = mediaQuery.size.width;
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.network(
              imgUrl,
              fit: BoxFit.fitHeight,
              height: mHeight * 0.12,
              width: mWidth * 0.31,
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: themeData.textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w600, color: greyColor),
                  ),
                  Text(
                    "Rs. $price",
                    style: themeData.textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w800, color: blackColor),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
