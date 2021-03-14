import 'package:flutter/foundation.dart';

class CartData with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartData(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}
