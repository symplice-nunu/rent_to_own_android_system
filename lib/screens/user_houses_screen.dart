import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';
import '../widgets/user_house_item.dart';
import '../widgets/app_drawer.dart';
import './edit_house_screen.dart';

class UserHousesScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshHouses(BuildContext context) async {
    await Provider.of<Houses>(context, listen: false)
        .fetchAndSetHouses(true);
  }

  @override
  Widget build(BuildContext context) {
    // final HousesData = Provider.of<Houses>(context);
    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Houses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditHouseScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshHouses(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshHouses(context),
                    child: Consumer<Houses>(
                      builder: (ctx, productsData, _) => Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemCount: productsData.items.length,
                              itemBuilder: (_, i) => Column(
                                    children: [
                                      UserHouseItem(
                                        productsData.items[i].id,
                                        productsData.items[i].title,
                                        productsData.items[i].imageUrl,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                            ),
                          ),
                    ),
                  ),
      ),
    );
  }
}
