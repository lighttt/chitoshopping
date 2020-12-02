import 'package:chito_shopping/theme/constants.dart';
import 'package:chito_shopping/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductListScreen extends StatelessWidget {
  static const String routeName = "/product_list_screen";

  @override
  Widget build(BuildContext context) {
    final themeConst = Theme.of(context);
    final title = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: blackColor,
              ),
              onPressed: () {})
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.5,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10),
          itemCount: 12,
          itemBuilder: (ctx, index) {
            return ProductItem(
              title: "Shoes",
              price: 2000,
              imgUrl:
                  "https://assets.ajio.com/medias/sys_master/root/ajio/catalog/5ef38fcbf997dd433b43d714/-473Wx593H-461205998-black-MODEL.jpg",
            );
          }),
    );
  }
}
