import 'package:flutter/material.dart';

import './product.dart';

// using ChangeNotifier mixin which works with the
// inherited widget's context
class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Nike Sneakers',
      description: 'Unused pair of black Nike sneakers!',
      price: 89.99,
      imageUrl:
          'https://i.imgur.com/P8AClNp.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Rugged City Boots',
      description: 'A nice pair of boots.',
      price: 119.99,
      imageUrl:
          'https://i.imgur.com/HNzWRYA.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Lace Dress',
      description: 'Cool and breezy - exactly what you need for the summer.',
      price: 19.99,
      imageUrl:
          'https://i.imgur.com/10nosA3.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Blue Jacket',
      description: 'Ready to take your style out of this world.',
      price: 49.99,
      imageUrl:
          'https://i.imgur.com/WtoegV5.jpg',
    ),
  ];

  // return copy of _items with getter
  // so as not to mutate state
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    notifyListeners();
  }
}
