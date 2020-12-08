import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageURL;
  final String description;
  final String rating;
  final double price;
  final String type;
  final String category;
  bool isFavourite;

  Product(
      {@required this.id,
      @required this.type,
      @required this.category,
      @required this.title,
      @required this.description,
      @required this.rating,
      @required this.price,
      @required this.imageURL,
      this.isFavourite = false});
}

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
        category: "Clothing",
        id: "First",
        title: "Watch",
        price: 2000,
        description: "The best watch you will ever find.",
        imageURL:
            "https://www.surfstitch.com/on/demandware.static/-/Sites-ss-master-catalog/default/dwef31ef54/images/MBB-M43BLK/BLACK-WOMENS-ACCESSORIES-ROSEFIELD-WATCHES-MBB-M43BLK_1.JPG",
        rating: "4.5",
        type: "Flash"),
    Product(
        category: "Sports",
        id: "second",
        title: "Shoes",
        price: 1500,
        description: "Quality and comfort shoes with fashionable style.",
        imageURL:
            "https://assets.adidas.com/images/w_600,f_auto,q_auto:sensitive,fl_lossy/e06ae7c7b4d14a16acb3a999005a8b6a_9366/Lite_Racer_RBN_Shoes_White_F36653_01_standard.jpg",
        rating: "4",
        type: "Flash"),
    Product(
        id: "third",
        category: "Electronics",
        title: "Laptop",
        price: 80000,
        description: "The compact and powerful gaming laptop under the budget.",
        imageURL:
            "https://d4kkpd69xt9l7.cloudfront.net/sys-master/images/h57/hdd/9010331451422/razer-blade-pro-hero-mobile.jpg",
        rating: "3.5",
        type: "New"),
    Product(
        category: "Clothing",
        id: "four",
        title: "T-Shirt",
        price: 1000,
        description: "A red color tshirt you can wear at any occassion.",
        imageURL:
            "https://5.imimg.com/data5/LM/NA/MY-49778818/mens-round-neck-t-shirt-500x500.jpg",
        rating: "3.5",
        type: "New"),
  ];

  //Get the product list
  List<Product> get products {
    return [..._products];
  }

  //Get the flash sale product list
  List<Product> get flashSaleProducts {
    return [..._products.where((prod) => prod.type == "Flash").toList()];
  }

  //Get the flash sale product list
  List<Product> get newProducts {
    return [..._products.where((prod) => prod.type == "New").toList()];
  }

  //Get the favourite product list
  List<Product> get favProducts {
    return [..._products.where((prod) => prod.isFavourite).toList()];
  }

  // Find product by id
  Product findProductById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  // toggle favourites
  void toggleFavourite(String id) {
    Product toggleProduct = _products.firstWhere((prod) => prod.id == id);
    toggleProduct.isFavourite = !toggleProduct.isFavourite;
    notifyListeners();
  }
}
