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
    final userProducts = productsProvider.userProducts;
    print(userProducts);
    return userProducts.length == 0
        ? Center(
            child: Text(
            "Please add your own products",
            textAlign: TextAlign.center,
            style: themeConst.textTheme.headline6,
          ))
        : ListView.builder(
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
                          Navigator.pushNamed(
                              context, EditProductScreen.routeName,
                              arguments: userProducts[index].id);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: themeConst.errorColor,
                        ),
                        onPressed: () async {
                          try {
                            await productsProvider
                                .deleteProduct(userProducts[index].id);
                            showDialog(
                                context: context,
                                builder: (dCtx) => AlertDialog(
                                      title: Text("Success!"),
                                      content: Text("Deleted the item!"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(dCtx);
                                          },
                                          color: themeConst.primaryColor,
                                          child: Text("Okay"),
                                        )
                                      ],
                                    ));
                          } catch (error) {
                            showDialog(
                                context: context,
                                builder: (dCtx) => AlertDialog(
                                      title: Text("Error!"),
                                      content: Text("Cannot delete the item!"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(dCtx);
                                          },
                                          child: Text("Okay"),
                                          color: themeConst.primaryColor,
                                        )
                                      ],
                                    ));
                          }
                        }),
                  ],
                ),
              ),
            ),
            itemCount: userProducts.length,
          );
  }
}
