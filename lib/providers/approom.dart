import 'package:flutter/foundation.dart';

class AppRoom {
  final String id;
  final String houseno;
  final String status;
  final int quantity;
  final double price;
  final String co;
  final String pai;
  final String pai1;
  final String pai2;
  final String at;
  final String at1;
  final String name;
  final String jobTtitle;
  final String company;

  AppRoom({
    @required this.id,
    @required this.houseno,
    @required this.status,
    @required this.quantity,
    @required this.price,
    @required this.co,
    @required this.pai,
    @required this.pai1,
    @required this.pai2,
    @required this.at,
    @required this.at1,
    @required this.name,
    @required this.jobTtitle,
    @required this.company,
  });
}

class Room with ChangeNotifier {
  Map<String, AppRoom> _items = {};

  Map<String, AppRoom> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, roomItem) {
      total += roomItem.price * roomItem.quantity;
    });
    return total;
  }

  void addItem(
    String houseId,
    double price,
    String houseno,
    String status,
    String pai,
    String pai1,
    String pai2,
    String at,
    String at1,
    String name,
    String co,
    String jobTtitle,
    String company,
  ) {
    if (_items.containsKey(houseId)) {
      // change quantity...
      _items.update(
        houseId,
        (existingRoomItem) => AppRoom(
              id: existingRoomItem.id,
              houseno: existingRoomItem.houseno,
              status: existingRoomItem.status,
              price: existingRoomItem.price,
              quantity: existingRoomItem.quantity + 1,
              pai: existingRoomItem.pai,
              pai1: existingRoomItem.pai1,
              pai2: existingRoomItem.pai2,
              at: existingRoomItem.at,
              at1: existingRoomItem.at1,
              name: existingRoomItem.name,
              co: existingRoomItem.co,
              jobTtitle: existingRoomItem.jobTtitle,
              company: existingRoomItem.company,
            ),
      );
    } else {
      _items.putIfAbsent(
        houseId,
        () => AppRoom(
              id: DateTime.now().toString(),
              houseno: houseno,
              status: status,
              price: price,
              quantity: 1,
              pai: pai,
              pai1: pai1,
              pai2: pai2,
              at: at,
              at1: at1,
              name: name,
              co: co,
              jobTtitle: jobTtitle,
              company: company,
            ),
      );
    }
    notifyListeners();
  }

  void removeItem(String houseId) {
    _items.remove(houseId);
    notifyListeners();
  }

  void removeSingleItem(String houseId) {
    if (!_items.containsKey(houseId)) {
      return;
    }
    if (_items[houseId].quantity > 1) {
      _items.update(
          houseId,
          (existingRoomItem) => AppRoom(
                id: existingRoomItem.id,
                houseno: existingRoomItem.houseno,
                status: existingRoomItem.status,
                price: existingRoomItem.price,
                quantity: existingRoomItem.quantity - 1,
                pai: existingRoomItem.pai,
                pai1: existingRoomItem.pai1,
                pai2: existingRoomItem.pai2,
                at: existingRoomItem.at,
                at1: existingRoomItem.at1,
                name: existingRoomItem.name,
                co: existingRoomItem.co,
                jobTtitle: existingRoomItem.jobTtitle,
                company: existingRoomItem.company,
              ));
    } else {
      _items.remove(houseId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
