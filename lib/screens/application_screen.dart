import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houseapplication.dart' show Application;
import '../widgets/application_item.dart';
import '../widgets/app_drawer.dart';

class ApplicationScreen extends StatelessWidget {
  static const routeName = '/application';

  @override
  Widget build(BuildContext context) {
    print('building application');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Application'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Application>(context, listen: false).fetchAndSetApplication(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Application>(
                builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.application.length,
                      itemBuilder: (ctx, i) => ApplicationItem(orderData.application[i]),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}
