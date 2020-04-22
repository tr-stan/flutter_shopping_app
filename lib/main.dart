import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/screens/platform_channel_methods.dart';
import 'package:provider/provider.dart';

import './screens/products_overview.dart';
import './screens/product_details.dart';
import './screens/cart_details.dart';
import './screens/order_history.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

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
        ChangeNotifierProvider.value(
          value: Orders(),
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
          OrderHistory.routeName: (ctx) => OrderHistory(),
          UserProducts.routeName: (ctx) => UserProducts(),
          EditProduct.routeName: (ctx) => EditProduct(),
          PlatformChannelMethods.routeName: (ctx) => PlatformChannelMethods(),
        },
      ),
    );
  }
}
