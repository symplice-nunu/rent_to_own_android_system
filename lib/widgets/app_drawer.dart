import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_to_own_android_system/screens/homee.dart';

import '../screens/orders_screen.dart';
import '../screens/user_houses_screen.dart';
import '../providers/auth.dart';
import '../helpers/custom_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('R.T.O Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.house_outlined),
            title: Text('Houses'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Requested Houses'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrdersScreen(),
              //   ),
              // );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Houses'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserHousesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.money_off_csred_rounded),
            title: Text('Return Bail'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HomeePage.routeName);
              
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
