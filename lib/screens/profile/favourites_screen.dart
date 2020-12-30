import 'package:chito_shopping/provider/products_provider.dart';
import 'package:chito_shopping/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  static const String routeName = "/favourites_screen";

  @override
  Widget build(BuildContext context) {
    final themeConst = Theme.of(context);
    final productsProvider = Provider.of<Products>(context);
    final loadedProducts = productsProvider.favProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favourites"),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10),
          itemCount: loadedProducts.length,
          itemBuilder: (ctx, index) {
            return ProductItem(
              id: loadedProducts[index].id,
            );
          }),
    );
  }
}
