import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> __items = [
    Product(
        id: "1",
        title: "cup cake",
        description: "cuk cakes vanilla",
        price: 10.00,
        imageUrl:
            "https://images.pexels.com/photos/853004/pexels-photo-853004.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    Product(
        id: "2",
        title: "chocolate cake",
        description: "chocilattte",
        price: 15.00,
        imageUrl:
            "https://images.pexels.com/photos/1854652/pexels-photo-1854652.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    Product(
        id: "3",
        title: "cup cake",
        description: "cuk cakes vanilla",
        price: 10.00,
        imageUrl:
            "https://images.pexels.com/photos/853004/pexels-photo-853004.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    Product(
        id: "4",
        title: "chocolate cake",
        description: "chocilattte",
        price: 15.00,
        imageUrl:
            "https://images.pexels.com/photos/1854652/pexels-photo-1854652.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    Product(
        id: "5",
        title: "cup cake",
        description: "cuk cakes vanilla",
        price: 10.00,
        imageUrl:
            "https://images.pexels.com/photos/853004/pexels-photo-853004.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    Product(
        id: "6",
        title: "chocolate cake",
        description: "chocilattte",
        price: 15.00,
        imageUrl:
            "https://images.pexels.com/photos/1854652/pexels-photo-1854652.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
  ];

  List<Product> get items {
    return [...__items];
  }

  List<Product> get favsOnly {
    return __items.where((element) => element.isFavorite).toList();
  }

  List<String> get titles {
    return __items
        .where((element) => element.title.isNotEmpty)
        .map((e) => e.title)
        .toList();
  }

  Product findById(String id) {
    return __items.firstWhere((prod) => prod.id == id);
  }
}
