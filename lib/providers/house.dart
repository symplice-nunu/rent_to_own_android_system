import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class House with ChangeNotifier {
  final String id;
  final String villagename;
  final String housedescription;
  final double price;
  final String imageUrl;
  bool isFavorite;

  House({
    @required this.id,
    @required this.villagename,
    @required this.housedescription,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        // 'https://rtotest-891ba-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
        'https://rent-to-own-6688f-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
