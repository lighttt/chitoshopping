import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  // add items to cart
  void addToCart(String productId, String title, double price) {
    //check if the item is already added
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    }
    // if item is not added
    else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  // get total items in cart
  int get totalCount {
    return _items == null ? 0 : _items.length;
  }

  //remove a single item from cart
  void removeSingleItem(String cartId) {
    if (!_items.containsKey(cartId)) {
      return;
    }
    if (_items[cartId].quantity > 1) {
      _items.update(
          cartId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1));
    } else {
      _items.remove(cartId);
    }
    notifyListeners();
  }

  //total amount of the cart
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // remove a item from cart
  void removeItem(String cartId) {
    if (!_items.containsKey(cartId)) {
      return;
    }
    _items.remove(cartId);
    notifyListeners();
  }

  //clear cart
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
