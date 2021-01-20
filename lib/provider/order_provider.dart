import 'dart:convert';
import 'package:chito_shopping/provider/API.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String status;

  OrderItem({
    @required this.id,
    @required this.status,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  String _token;
  String _userId;

  Orders(this._token, this._userId);

  /// setting token and user id
  void setTokenAndId(String token, String userId) {
    _token = token;
    _userId = userId;
  }

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  //fetch all orders
  Future<List<OrderItem>> fetchAllAndSetOrders() async {
    try {
      final response =
          await http.get(API.orders + "$_userId.json" + "?auth=$_token");
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return [];
      }
      final List<OrderItem> _loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        _loadedOrders.add(
          OrderItem(
            id: orderId,
            status: orderData['status'],
            amount: double.parse(orderData['amount'].toString()),
            products: (orderData['products'] as List<dynamic>)
                .map((cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    price: cartItem['price'],
                    quantity: cartItem['quantity']))
                .toList(),
            dateTime: DateTime.parse(
              orderData['dateTime'],
            ),
          ),
        );
      });
      _orders = _loadedOrders.reversed.toList();
      return _orders;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  //add cart to order
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      final response =
          await http.post(API.orders + "$_userId.json" + "?auth=$_token",
              body: json.encode({
                'amount': total,
                'dateTime': DateTime.now().toIso8601String(),
                'status': "Pending",
                'products': cartProducts
                    .map((cp) => {
                          'id': cp.id,
                          'quantity': cp.quantity,
                          'price': cp.price,
                          'title': cp.title,
                        })
                    .toList()
              }));
      final id = json.decode(response.body);
      _orders.add(OrderItem(
          id: id['name'],
          amount: total,
          status: "Pending",
          products: cartProducts,
          dateTime: DateTime.now()));
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
