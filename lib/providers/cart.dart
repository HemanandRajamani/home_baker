import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:home_baker/providers/cart_data.dart';

class Cart with ChangeNotifier {
  Map<String, CartData> _items = {};

  Map<String, CartData> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.entries.length;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existing) => CartData(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartData(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }

    notifyListeners();
  }

  void decrementQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existing) => CartData(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity > 0 ? existing.quantity - 1 : 0));
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existing) => CartData(
              id: existing.id,
              title: existing.title,
              price: existing.price,
              quantity: existing.quantity + 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
