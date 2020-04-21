import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import './cart_details.dart';

enum FilterOptions { Favorites, All }

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showFavoritesOnly = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<Products>(context).fetchProducts();

    // Future.delayed works with using the Provider.of or
    // the Modal.of methods in the initState lifecycle
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchProducts();
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit == false) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('¡Shop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showFavoritesOnly = true;
                  } else {
                    _showFavoritesOnly = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites),
                PopupMenuItem(
                    child: Text('Show All'), value: FilterOptions.All),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Consumer<Cart>(
                // IconButton is set as static child of Consumer and passed to
                // its builder func so it does not rebuild when notified by provider
                builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartDetails.routeName);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            // : ProductsGrid(_showFavoritesOnly),
            : Center(
                child: Column(
                  children: <Widget>[
                    ...Provider.of<Products>(context)
                        .catText
                        .map((cat) => Flexible(child: Text(cat)))
                        .toList(),
                    FlatButton(
                      child: Text('Get Cat Info!'),
                      onPressed: () {
                        Provider.of<Products>(context)
                            .listCat(3, "Koguma", 1, "Tristan");
                      },
                    ),
                    Flexible(
                      child: Text(Provider.of<Products>(context).platformText),
                    ),
                    FlatButton(
                      child: Text("Change Number"),
                      onPressed: () {
                        Provider.of<Products>(context).listProduct(
                            Provider.of<Products>(context)
                                .findById("-LowMybz8hLRutDlfRdf"));
                      },
                    ),
                    Flexible(
                      child: Text(Provider.of<Products>(context).deletedCatText),
                    ),
                    FlatButton(
                      child: Text("Delete a Cat!"),
                      onPressed: () {
                        // Provider.of<Products>(context).deleteCat(0);

                      },
                    ),
                    // ...Provider.of<Products>(context).items.map((product) => Text(product.id))
                  ],
                ),
              ));
  }
}
