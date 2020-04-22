import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/providers/products.dart';
import 'package:provider/provider.dart';

class PlatformChannelMethods extends StatelessWidget {
  static const routeName = 'platform-channel-methods';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...Provider.of<Products>(context)
                .catsText
                .map((cat) => Flexible(child: Text(cat)))
                .toList(),
            FlatButton(
              child: Text('Get Cat Info!'),
              onPressed: () {
                Provider.of<Products>(context).listCats();
              },
            ),
            Flexible(child: Text(Provider.of<Products>(context).catText)),
            FlatButton(
              child: Text('Create a cat!'),
              onPressed: () {
                Provider.of<Products>(context)
                    .createCat(2, "Kronos", 1, "Natasha");
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
                Provider.of<Products>(context).deleteCat(0);
              },
            ),
            // ...Provider.of<Products>(context).items.map((product) => Text(product.id))
          ],
        ),
      ),
    );
  }
}
