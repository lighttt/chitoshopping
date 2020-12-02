import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product_detail_screen";
  ThemeData themeConst;

  Chip _sizeChips({@required String title, @required Color color}) {
    return Chip(
      label: Text(
        title,
        style: themeConst.textTheme.subtitle1
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color,
    );
  }

  ListTile _detailTiles({@required String title, @required String desc}) {
    return ListTile(
        title: Text(
          title,
          style: themeConst.textTheme.headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          desc,
          style: themeConst.textTheme.subtitle2.copyWith(color: greyColor),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mHeight = mediaQuery.size.height;
    themeConst = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoes"),
      ),
      body: ListView(
        children: [
          Image.network(
            "https://assets.ajio.com/medias/sys_master/root/ajio/catalog/5ef38fcbf997dd433b43d714/-473Wx593H-461205998-black-MODEL.jpg",
            height: mHeight * 0.4,
            fit: BoxFit.contain,
          ),
          ListTile(
            title: Text(
              "Rs. 1500",
              style: themeConst.textTheme.headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Goldstar Shoes Blue JX123",
                style: themeConst.textTheme.subtitle1),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: themeConst.accentColor),
                    SizedBox(
                      width: 1,
                    ),
                    Text("4.5"),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: themeConst.primaryColor),
                    SizedBox(
                      width: 1,
                    ),
                    Text("100"),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              "Size",
              style: themeConst.textTheme.headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sizeChips(
                title: "S",
                color: Colors.orange[200],
              ),
              _sizeChips(
                title: "M",
                color: Colors.pink[200],
              ),
              _sizeChips(
                title: "L",
                color: Colors.lightBlue[200],
              ),
              _sizeChips(
                title: "XL",
                color: Colors.green[200],
              ),
            ],
          ),
          _detailTiles(
            title: "Brand",
            desc: "GoldStar",
          ),
          _detailTiles(
            title: "Category",
            desc: "Men Shoes",
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 10, bottom: 10),
            child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: themeConst.primaryColor,
                textColor: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
                label: Text("Add to Cart")),
          )
        ],
      ),
    );
  }
}

// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// IconButton(
// padding: const EdgeInsets.all(0),
// icon: Icon(
// FontAwesomeIcons.minus,
// size: 18,
// ),
// onPressed: () {}),
// Text(
// "1",
// style: themeConst.textTheme.headline4
//     .copyWith(fontWeight: FontWeight.w600),
// ),
// IconButton(
// padding: const EdgeInsets.all(0),
// icon: Icon(
// FontAwesomeIcons.plus,
// size: 18,
// ),
// onPressed: () {})
// ],
// )
