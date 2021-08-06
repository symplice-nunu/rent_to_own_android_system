import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './approom.dart';

class HouseApplication {
  final String id;
  final double amount;
  final List<AppRoom> houses;
  final DateTime dateTime;

  HouseApplication({
    @required this.id,
    @required this.amount,
    @required this.houses,
    @required this.dateTime,
  });
}

class Application with ChangeNotifier {
  List<HouseApplication> _orders = [];
  final String authToken;
  final String userId;

  Application(this.authToken, this.userId, this._orders);

  List<HouseApplication> get application {
    return [..._orders];
  }

  Future<void> fetchAndSetApplication() async {
    final url = 'https://house-6dc86-default-rtdb.firebaseio.com/houseapplication/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<HouseApplication> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        HouseApplication(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          houses: (orderData['houses'] as List<dynamic>)
              .map(
                (item) => AppRoom(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      houseno: item['houseno'],
                      status: item['status'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> fetchAndSetPayments() async {
    final url = 'https://house-6dc86-default-rtdb.firebaseio.com/monthlypayment/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<HouseApplication> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        HouseApplication(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          houses: (orderData['houses'] as List<dynamic>)
              .map(
                (item) => AppRoom(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      houseno: item['houseno'],
                      status: item['status'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

Future<void> fetchAndSetBail() async {
    final url = 'https://house-6dc86-default-rtdb.firebaseio.com/bailpayment/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<HouseApplication> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        HouseApplication(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          houses: (orderData['houses'] as List<dynamic>)
              .map(
                (item) => AppRoom(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      houseno: item['houseno'],
                      status: item['status'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }


  Future<void> addApplication(List<AppRoom> roomHouses, double total) async {
    final url = 'https://house-6dc86-default-rtdb.firebaseio.com/houseapplication/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'houses': roomHouses
            .map((cp) => {
                  'id': cp.id,
                  'houseno': cp.houseno,
                  'status': "Pending....",
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      HouseApplication(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        houses: roomHouses,
      ),
    );
    notifyListeners();
  }
}
