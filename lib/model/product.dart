import 'package:flutter/foundation.dart';

class Product {
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
