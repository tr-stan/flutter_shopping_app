import 'package:flutter/foundation.dart';

import './cart.dart';

class Order {
  final String id;
  final String amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: total.toStringAsFixed(2),
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
