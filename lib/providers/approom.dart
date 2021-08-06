import 'package:flutter/foundation.dart';

class AppRoom {
  final String id;
  final String houseno;
  final String status;
  final int quantity;
  final double price;

  AppRoom({
    @required this.id,
    @required this.houseno,
    @required this.status,
    @required this.quantity,
    @required this.price,
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
