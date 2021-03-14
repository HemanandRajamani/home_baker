import 'package:flutter/material.dart';
import 'package:home_baker/providers/orders.dart';
import 'package:home_baker/screens/cart/cart_screen.dart';
import 'package:home_baker/screens/orders/orders_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_baker/screens/product/products_overview_screen.dart';
import 'screens/product/products_overview_screen.dart';
import 'screens/product/product_details_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Orders()),
        ],
        child: MaterialApp(
            title: "Home Baker",
            theme:
                ThemeData(primarySwatch: Colors.lime, accentColor: Colors.lime),
            home: ProductsOverviewScreen(),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen()
            }));
  }
}
