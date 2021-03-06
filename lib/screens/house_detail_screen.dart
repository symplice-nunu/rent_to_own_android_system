import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/houses.dart';

class HouseDetailScreen extends StatelessWidget {
  
  static const routeName = '/house-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; 
    final loadedHouse = Provider.of<Houses>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedHouse.villagename),
              background: Hero(
                tag: loadedHouse.id,
                child: Image.network(
                  loadedHouse.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  '\$${loadedHouse.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    loadedHouse.housedescription,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 800,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
