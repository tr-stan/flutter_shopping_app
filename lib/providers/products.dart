import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    // w/ firebase u can name the collection as you wish, here '/products'
    // but other databases/services might have stricly defined endpoints
    const url = 'https://first-flutter-87cf6.firebaseio.com/products.json';
    http.post(
      url,
      body: json.encode({
        'title': product.title,
        'imageUrl': product.imageUrl,
        'description': product.description,
        'price': product.price,
        'isFavorite': product.isFavorite,
      }),
    ).then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct,); // adds to start of list
      notifyListeners();
    });
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...failed to update product');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
