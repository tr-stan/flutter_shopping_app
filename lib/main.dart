import 'package:flutter/material.dart';

import './screens/products_overview.dart';
import './screens/product_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tr;stan\'s ¡Shop',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        fontFamily: 'Corben',
      ),
      home: ProductsOverview(),
      routes: {
        // '/': (ctx) => ProductsOverviewScreen(),
        ProductDetails.routeName: (ctx) => ProductDetails(),
      },
    );
  }
}
