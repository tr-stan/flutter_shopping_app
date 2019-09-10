import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview.dart';
import './screens/product_details.dart';
import './screens/cart_details.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'tr;stan\'s ¡Shop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: 'Rubik',
        ),
        home: ProductsOverview(),
        routes: {
          // '/': (ctx) => ProductsOverviewScreen(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          CartDetails.routeName: (ctx) => CartDetails(),
        },
      ),
    );
  }
}
