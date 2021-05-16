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
              
              title: 
              Text(
                loadedHouse.villagename,
                ),
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
                    color: Colors.teal,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'House Description',
                    
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                
                    loadedHouse.housedescription,
                    
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                    ),
                    // textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'House ID',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 2,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.houseno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,

                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                
                  // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'Number of Rooms',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.roomno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'Number of Saloons',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.saloonno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'Number of Toilets and Birthrooms',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.tbno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'Number of Kitchens',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.kitchenno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'Number of Extra Houses',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.ehouseno,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                
                    'House Location',
                    
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 13,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                  
                    loadedHouse.houselocation,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  ),
                ),
                // SizedBox(height: 10,),
                Divider(),
              ],
            ),
          ),
          
        ],
      ),
      
    );
  }
}
