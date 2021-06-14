import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './house.dart';
import './rentagreement.dart';

class Houses with ChangeNotifier {
  List<House> _items = [
   
  ];
  List<RentAgreement> _itemsa = [
   
  ];
  // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  Houses(this.authToken, this.userId, this._items, this._itemsa);

  List<House> get items {
    
    return [..._items];
  }
List<RentAgreement> get itemsa {
    
    return [..._itemsa];
  }
  List<House> get favoriteItems {
    return _items.where((housItem) => housItem.isFavorite).toList();
  }

  House findById(String id) {
    return _items.firstWhere((hous) => hous.id == id);
  }
  RentAgreement findByIda(String id) {
    return _itemsa.firstWhere((hous) => hous.id == id);
  }

 
  Future<void> fetchAndSetHouses([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://rtotest-891ba-default-rtdb.firebaseio.com/house.json?auth=$authToken&$filterString';
        // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://rtotest-891ba-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
          // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<House> loadedHouses = [];
      extractedData.forEach((housId, housData) {
        loadedHouses.add(House(
          id: housId,
          villagename: housData['villagename'],
          houseno: housData['houseno'],
          roomno: housData['roomno'],
          saloonno: housData['saloonno'],
          tbno: housData['tbno'],
          kitchenno: housData['kitchenno'],
          ehouseno: housData['ehouseno'],
          houselocation: housData['houselocation'],
          housedescription: housData['housedescription'],
          price: housData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[housId] ?? false,
          imageUrl: housData['imageUrl'],
        ));
      });
      _items = loadedHouses;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

   Future<void> fetchAndRentAgreement([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://rtotest-891ba-default-rtdb.firebaseio.com/rentagreement.json?auth=$authToken&$filterString';
        // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://rtotest-891ba-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
          // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<RentAgreement> loadedHouses = [];
      extractedData.forEach((housId, housData) {
        loadedHouses.add(RentAgreement(
          id: housId,
          investorname: housData['investorname'],
          rentername: housData['rentername'],
          houseno: housData['houseno'],
          location: housData['location'],
          date: housData['date'],
          isFavorite:
              favoriteData == null ? false : favoriteData[housId] ?? false,
        ));
      });
      _itemsa = loadedHouses;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }


  Future<void> addHouse(House house) async {
    final url =
        'https://rtotest-891ba-default-rtdb.firebaseio.com/house.json?auth=$authToken';
        //  'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'villagename': house.villagename,
          'houseno': house.houseno,
          'roomno': house.roomno,
          'saloonno': house.saloonno,
          'tbno': house.tbno,
          'kitchenno': house.kitchenno,
          'ehouseno': house.ehouseno,
          'houselocation': house.houselocation,
          'housedescription': house.housedescription,
          'imageUrl': house.imageUrl,
          'price': house.price,
          'creatorId': userId,
        }),
      );
      final newHouse = House(
        villagename: house.villagename,
        houseno: house.houseno,
        roomno: house.roomno,
        saloonno: house.saloonno,
        tbno: house.tbno,
        kitchenno: house.kitchenno,
        ehouseno: house.ehouseno,
        houselocation: house.houselocation,
        housedescription: house.housedescription,
        price: house.price,
        imageUrl: house.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newHouse);
      // _items.insert(0, newHouse); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
Future<void> addRentAgreement(RentAgreement rentAgreement) async {
    final url =
        'https://rtotest-891ba-default-rtdb.firebaseio.com/rentagreement.json?auth=$authToken';
        //  'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses.json?auth=$authToken';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'investorname':rentAgreement.investorname,
          'rentername':rentAgreement.rentername,
          'houseno': rentAgreement.houseno,
          'location': rentAgreement.location,
          'date': timestamp.toIso8601String(),
          'creatorId': userId,
        }),
      );
      final newAgreement = RentAgreement(
        investorname: rentAgreement.investorname,
        rentername: rentAgreement.rentername,
        houseno: rentAgreement.houseno,
        location: rentAgreement.location,
        date: rentAgreement.date,
        id: json.decode(response.body)['name'],
      );
      _itemsa.add(newAgreement);
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
          'https://rtotest-891ba-default-rtdb.firebaseio.com/house/$id.json?auth=$authToken';
          // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'villagename': newHouse.villagename,
            'houseno': newHouse.houseno,
            'roomno': newHouse.roomno,
            'saloonno': newHouse.saloonno,
            'tbno': newHouse.tbno,
            'kitchenno': newHouse.kitchenno,
            'ehouseno': newHouse.ehouseno,
            'houselocation': newHouse.houselocation,
            'housedescription': newHouse.housedescription,
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
        'https://rtotest-891ba-default-rtdb.firebaseio.com/house/$id.json?auth=$authToken';
        // 'https://rent-to-own-6688f-default-rtdb.firebaseio.com/houses/$id.json?auth=$authToken';
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
