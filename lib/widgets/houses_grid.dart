import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';
import './house_item.dart';

class HousesGrid extends StatelessWidget {
  final bool showFavs;

  HousesGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Houses>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: products[i],
            child: HouseItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
