import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // declare scaffold var to be used w/ snackbar below
    // this way the snackbar will know the context to display in
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProduct.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                 await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  // scaffold has context since declared at top
                  // of build method, outside of the future we are in rn
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deletion failed.'),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
