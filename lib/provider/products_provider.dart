import 'dart:convert';
import 'dart:io';

import 'package:chito_shopping/provider/API.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  String imageURL;
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
    // Product(
    //     category: "Clothing",
    //     id: "First",
    //     title: "Watch",
    //     price: 2000,
    //     description: "The best watch you will ever find.",
    //     imageURL:
    //         "https://www.surfstitch.com/on/demandware.static/-/Sites-ss-master-catalog/default/dwef31ef54/images/MBB-M43BLK/BLACK-WOMENS-ACCESSORIES-ROSEFIELD-WATCHES-MBB-M43BLK_1.JPG",
    //     rating: "4.5",
    //     type: "Flash"),
    // Product(
    //     category: "Sports",
    //     id: "second",
    //     title: "Shoes",
    //     price: 1500,
    //     description: "Quality and comfort shoes with fashionable style.",
    //     imageURL:
    //         "https://assets.adidas.com/images/w_600,f_auto,q_auto:sensitive,fl_lossy/e06ae7c7b4d14a16acb3a999005a8b6a_9366/Lite_Racer_RBN_Shoes_White_F36653_01_standard.jpg",
    //     rating: "4",
    //     type: "Flash"),
    // Product(
    //     id: "third",
    //     category: "Electronics",
    //     title: "Laptop",
    //     price: 80000,
    //     description: "The compact and powerful gaming laptop under the budget.",
    //     imageURL:
    //         "https://d4kkpd69xt9l7.cloudfront.net/sys-master/images/h57/hdd/9010331451422/razer-blade-pro-hero-mobile.jpg",
    //     rating: "3.5",
    //     type: "New"),
    // Product(
    //     category: "Clothing",
    //     id: "four",
    //     title: "T-Shirt",
    //     price: 1000,
    //     description: "A red color tshirt you can wear at any occassion.",
    //     imageURL:
    //         "https://5.imimg.com/data5/LM/NA/MY-49778818/mens-round-neck-t-shirt-500x500.jpg",
    //     rating: "3.5",
    //     type: "New"),
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

  // fetch all the product from firebase
  Future<void> fetchAllProducts() async {
    try {
      print(API.products);
      final response = await http.get(API.products);
      final allMap = json.decode(response.body) as Map<String, dynamic>;
      List<Product> allProducts = [];
      allMap.forEach((prodId, prodData) {
        allProducts.add(Product(
            id: prodId,
            type: prodData['type'],
            category: prodData['category'],
            title: prodData['title'],
            description: prodData['description'],
            rating: prodData['rating'],
            price: double.parse(prodData["price"].toString()),
            imageURL: prodData['imageURL']));
      });
      _products = allProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  //add product
  Future<void> addProduct(Product product) async {
    //add to firebase
    try {
      final response = await http.post(API.products,
          body: json.encode({
            "type": product.type,
            "category": product.category,
            "title": product.title,
            "description": product.description,
            "rating": product.rating,
            "price": product.price,
            "imageURL": product.imageURL
          }));
      print(response.body);
      final id = json.decode(response.body);
      final newProduct = Product(
          id: id["name"],
          type: product.type,
          category: product.category,
          title: product.title,
          description: product.description,
          rating: product.rating,
          price: product.price,
          imageURL: product.imageURL);
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  //update product
  Future<void> updateProduct(
      String id, Product updatedProduct, File imageFile) async {
    try {
      final prodIndex = _products.indexWhere((prod) => prod.id == id);
      Map updateMap = {
        "type": updatedProduct.type,
        "category": updatedProduct.category,
        "title": updatedProduct.title,
        "description": updatedProduct.description,
        "rating": updatedProduct.rating,
        "price": updatedProduct.price,
        "imageURL": updatedProduct.imageURL
      };
      if (imageFile != null) {
        updateMap["imageURL"] = await uploadProductPhoto(id, imageFile);
        updatedProduct.imageURL = updateMap["imageURL"];
      }
      final response = await http.patch(API.baseUrl + "/products/$id.json",
          body: json.encode(updateMap));
      print(response.body);
      _products[prodIndex] = updatedProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  //delete product
  Future<void> deleteProduct(String productId) async {
    try {
      final prodIndex = _products.indexWhere((prod) => prod.id == productId);
      Product existingProduct = _products[prodIndex];
      //remove the product
      _products.removeAt(prodIndex);
      notifyListeners();
      final response =
          await http.delete(API.baseUrl + "/products/$productId.json");
      // if firebase could not delete
      if (response.statusCode >= 400) {
        _products.insert(prodIndex, existingProduct);
        notifyListeners();
        throw HttpException("Could not be deleted! Try again!");
      } else {
        existingProduct = null;
      }
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // Upload product photo to firebase
  Future<String> uploadProductPhoto(String productId, File imageFile) async {
    try {
      String imageFileName = imageFile.path.split('/').last;
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('products/$productId/$imageFileName');

      UploadTask uploadTask = storageRef.putFile(imageFile);
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
