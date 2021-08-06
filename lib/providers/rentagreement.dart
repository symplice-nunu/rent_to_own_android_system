import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RentAgreement with ChangeNotifier {
  final String id;
  final String investorname;
  final String rentername;
  final String houseno;
  final String location;
  final String price;
  final String bail;
  final String date;
  bool isFavorite;

  RentAgreement({
    @required this.id,
    @required this.investorname,
    @required this.rentername,
    @required this.houseno,
    @required this.location,
    @required this.price,
    @required this.bail,
    @required this.date,
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
        'https://house-6dc86-default-rtdb.firebaseio.com/$userId/$id.json?auth=$token';
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
