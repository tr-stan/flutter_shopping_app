import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

// using ChangeNotifier mixin which works with the
// inherited widget's context
class Products with ChangeNotifier {
  static const platform = const MethodChannel('products.ishop.app');
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Nike Sneakers',
    //   description: 'Unused pair of black Nike sneakers!',
    //   price: 89.99,
    //   imageUrl: 'https://i.imgur.com/P8AClNp.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Rugged City Boots',
    //   description: 'A nice pair of boots.',
    //   price: 119.99,
    //   imageUrl: 'https://i.imgur.com/HNzWRYA.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Lace Dress',
    //   description: 'Cool and breezy - exactly what you need for the summer.',
    //   price: 59.99,
    //   imageUrl: 'https://i.imgur.com/10nosA3.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Blue Jacket',
    //   description: 'Ready to take your style out of this world.',
    //   price: 65.99,
    //   imageUrl: 'https://i.imgur.com/WtoegV5.jpg',
    // ),
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

  String _platformText = 'waiting';
  List<String> _catsText = ['meow'];
  String _catText = "No Kitty Created yet";
  String _deletedCatText = 'no deleted cat';
  String _deletedCatsText = 'no deleted cats';

  String get platformText => _platformText;
  List<String> get catsText => _catsText;
  String get catText => _catText;
  String get deletedCatText => _deletedCatText;
  String get deletedCatsText => _deletedCatsText;

  listProduct(Product product) async {
    String productText;
    try {
      final String result =
          await platform.invokeMethod('listProduct', <String, dynamic>{
        "id": product.id,
        "title": product.title,
      });
      productText = result;
    } on PlatformException catch (e) {
      productText = "Failed to list the product: ${e.message}";
    }
    _platformText = productText;
    notifyListeners();
  }

  listCats() async {
    List<String> resultText;
    try {
      final List<dynamic> result = await platform.invokeMethod(
        'listCats',
      );
      final finalText = List<String>.from(result);
      resultText = finalText;
    } on PlatformException catch (e) {
      resultText = ["Failed to list the cat info: ${e.message}"];
    }
    _catsText = resultText;
    notifyListeners();
  }

  createCat(int id, String name, int age, String owner) async {
    String resultText;
    try {
      final String result = await platform.invokeMethod(
        'createCat',
        <String, dynamic>{"id": id, "name": name, "age": age, "owner": owner},
      );
      resultText = result;
    } on PlatformException catch (e) {
      resultText = "Failed to create cat: ${e.message}";
    }
    _catText = resultText;
    notifyListeners();
  }

  deleteCat(int id) async {
    String deleteResultText;
    try {
      final String result = await platform.invokeMethod(
        'deleteCat',
        <String, int>{"id": id},
      );
      deleteResultText = result;
    } on PlatformException catch (e) {
      deleteResultText = "Failed to delete cat with id $id";
    }
    _deletedCatText = deleteResultText;
    notifyListeners();
  }

  deleteCats(int id) async {
    String deletedCatsResultText;
    try {
      final String result = await platform.invokeMethod(
        'deleteCats',
        <String, int>{"id": id},
      );
      deletedCatsResultText = result;
    } on PlatformException catch (e) {
      deletedCatsResultText = "Failed to delete cats: ${e.message}";
    }
    _deletedCatsText = deletedCatsResultText;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    const url = 'https://first-flutter-87cf6.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final resData = json.decode(response.body) as Map<String, dynamic>;
      print(resData);
      final List<Product> loadedProducts = [];
      resData.forEach((id, data) {
        loadedProducts.add(Product(
          id: id,
          title: data['title'],
          description: data['description'],
          price: data['price'],
          imageUrl: data['imageUrl'],
          isFavorite: data['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    // w/ firebase u can name the collection as you wish, here '/products'
    // but other databases/services might have stricly defined endpoints
    const url = 'https://first-flutter-87cf6.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'imageUrl': product.imageUrl,
          'description': product.description,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      // print(json.decode(response.body));
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
    } catch (error) {
      print(error);
      // throwing error just so we can use .catchError in edi_product screen
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final url =
          'https://first-flutter-87cf6.firebaseio.com/products/$id.json';
      try {
        await http.patch(
          url,
          body: json.encode({
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'title': newProduct.title,
          }),
        );
        _items[productIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    } else {
      print('...failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://first-flutter-87cf6.firebaseio.com/products/$id.json';
    // following utilizes 'optimistic updating' pattern
    final productIndex = _items.indexWhere((product) => product.id == id);
    var currentProduct = _items[productIndex];
    _items.removeAt(productIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(productIndex, currentProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    currentProduct = null;
  }
}
