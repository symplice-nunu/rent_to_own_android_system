import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './house.dart';

class Houses with ChangeNotifier {
  List<House> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  Houses(this.authToken, this.userId, this._items);

  List<House> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<House> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  House findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetHouses([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://popishop-24d25.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://popishop-24d25.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<House> loadedHouses = [];
      extractedData.forEach((prodId, prodData) {
        loadedHouses.add(House(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedHouses;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addHouse(House house) async {
    final url =
        'https://popishop-24d25.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': house.title,
          'description': house.description,
          'imageUrl': house.imageUrl,
          'price': house.price,
          'creatorId': userId,
        }),
      );
      final newHouse = House(
        title: house.title,
        description: house.description,
        price: house.price,
        imageUrl: house.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newHouse);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateHouse(String id, House newHouse) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://popishop-24d25.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newHouse.title,
            'description': newHouse.description,
            'imageUrl': newHouse.imageUrl,
            'price': newHouse.price
          }));
      _items[prodIndex] = newHouse;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteHouse(String id) async {
    final url =
        'https://popishop-24d25.firebaseio.com/products/$id.json?auth=$authToken';
    final existingHouseIndex = _items.indexWhere((prod) => prod.id == id);
    var existingHouse = _items[existingHouseIndex];
    _items.removeAt(existingHouseIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingHouseIndex, existingHouse);
      notifyListeners();
      throw HttpException('Could not delete house.');
    }
    existingHouse = null;
  }
}
