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
      imageUrl: 'https://i.imgur.com/P8AClNp.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Rugged City Boots',
      description: 'A nice pair of boots.',
      price: 119.99,
      imageUrl: 'https://i.imgur.com/HNzWRYA.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Lace Dress',
      description: 'Cool and breezy - exactly what you need for the summer.',
      price: 59.99,
      imageUrl: 'https://i.imgur.com/10nosA3.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Blue Jacket',
      description: 'Ready to take your style out of this world.',
      price: 65.99,
      imageUrl: 'https://i.imgur.com/WtoegV5.jpg',
    ),
  ];

  // return copy of _items with getter
  // so as not to mutate state
  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      imageUrl: product.imageUrl,
      description: product.description,
      price: product.price,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct,); // adds to start of list
    notifyListeners();
  }
}
