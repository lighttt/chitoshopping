import 'package:chito_shopping/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  ThemeData themeConst;
  double mHeight, mWidth;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    mHeight = mediaConst.size.height;
    mWidth = mediaConst.size.width;
    themeConst = Theme.of(context);
    final productsProvider = Provider.of<Products>(context);
    final userProducts = productsProvider.products;
    return ListView.builder(
      itemBuilder: (ctx, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(userProducts[index].imageURL),
            radius: 40,
          ),
          title: Text("${userProducts[index].title}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.edit, color: themeConst.primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, EditProductScreen.routeName,
                        arguments: userProducts[index].id);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: themeConst.errorColor,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
      itemCount: userProducts.length,
    );
  }
}
