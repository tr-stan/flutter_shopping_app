import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFaves;

  ProductsGrid(this.showFaves);

  @override
  Widget build(BuildContext context) {
    // Provider.of can only be used in a widget with a(n)
    // (in)direct parent widget that has set up a provider
    final productsData = Provider.of<Products>(context);
    // uses the getter in the products provider class
    final products =
        showFaves ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // .value method ensures provider works even if
        // data changes for widget list items in list
        value: products[i],
        child: ProductItem(),
      ),
      // allows us to define how grid should generally be structured
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
