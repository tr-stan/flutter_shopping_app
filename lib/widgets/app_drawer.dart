import 'package:flutter/material.dart';
import '../screens/order_history.dart';
import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, size:26),
      title: Text(title),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Drawer'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile('Shop', Icons.shop, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Divider(),
          buildListTile('Orders', Icons.payment, () {
            Navigator.of(context).pushReplacementNamed(OrderHistory.routeName);
          }),
          Divider(),
          buildListTile('Manage Products', Icons.edit, () {
            Navigator.of(context).pushReplacementNamed(UserProducts.routeName);
          }),
        ],
      ),
    );
  }
}
